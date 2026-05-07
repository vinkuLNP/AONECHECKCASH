import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/create_cheque_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/create_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/delete_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/fetch_cheques_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/fetch_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/update_cheque_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/update_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/upload_image_usecase.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  final UploadImageUseCase uploadImage;
  final CreateDocumentUseCase createDoc;
  final FetchDocumentsUseCase fetchDocs;
  final FetchChequesUseCase fetchCheques;
  final CreateChequeUsecase createChequeUsecase;
  final UpdateChequeUsecase updateChequeUsecase;
  final UpdateDocumentsUseCase updateDoc;
  final DeleteDocumentUseCase deleteDoc;

  UploadProvider({
    required this.uploadImage,
    required this.createDoc,
    required this.fetchDocs,
    required this.updateDoc,
    required this.deleteDoc,
    required this.fetchCheques,
    required this.createChequeUsecase,
    required this.updateChequeUsecase,
  });

  List<Item> items = [];
  bool isLoading = false;

  Future<void> loadDocuments() async {
    isLoading = true;
    notifyListeners();
    final userId = await SessionManager.getClientRecordId();
    if (userId == null) {
      items = [];
    } else {
      items = await fetchDocs(userId);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> saveDocument({
    String? id,
    required String description,
    File? frontImage,
    File? backImage,
    String? existingFrontFileId,
    String? existingBackFileId,
  }) async {
    isLoading = true;
    notifyListeners();

    final userId = await SessionManager.getClientRecordId();

    if (userId == null) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    String? frontFileId;
    String? backFileId;

    if (frontImage != null) {
      frontFileId = await uploadImage(frontImage, KnackFields.frontImage);
    } else if (existingFrontFileId != null) {
      frontFileId = existingFrontFileId;
    } else {}

    if (backImage != null) {
      backFileId = await uploadImage(backImage, KnackFields.backImage);
    } else if (existingBackFileId != null) {
      backFileId = existingBackFileId;
    } else {}

    if ((frontFileId == null || frontFileId.isEmpty) ||
        (backFileId == null || backFileId.isEmpty)) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    bool success = false;

    try {
      if (id != null) {
        success = await updateDoc(id, description, frontFileId, backFileId);
      } else {
        success = await createDoc(description, frontFileId, backFileId, userId);
      }
    } catch (e) {
      success = false;
    }

    await loadDocuments();

    isLoading = false;
    notifyListeners();

    return success;
  }

  Future<void> deleteItem(String id) async {
    isLoading = true;
    notifyListeners();

    await deleteDoc(id);

    await loadDocuments();

    isLoading = false;
    notifyListeners();
  }

  String extractFileId(String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments.last;
  }

  ///////------------------- For Cheque Management ------------------///////

  List<Cheque> _cheques = [];

  ChequeStatus? _filterStatus;

  int _statusPriority(ChequeStatus status) {
    switch (status) {
      case ChequeStatus.needMoreInfo:
        return 0;
      case ChequeStatus.approved:
        return 1;
      case ChequeStatus.underReview:
        return 2;
      case ChequeStatus.rejected:
        return 3;
    }
  }

  void setFilter(ChequeStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  ChequeStatus? get currentFilter => _filterStatus;

  List<Cheque> get cheques {
    List<Cheque> filtered = _filterStatus == null
        ? [..._cheques]
        : _cheques.where((c) => c.status == _filterStatus).toList();

    filtered.sort(
      (a, b) => _statusPriority(a.status).compareTo(_statusPriority(b.status)),
    );

    return filtered;
  }

  Future<void> loadCheques() async {
    isLoading = true;
    notifyListeners();

    final userId = await SessionManager.getClientRecordId();

    if (userId == null) {
      _cheques = [];
    } else {
      _cheques = await fetchCheques(userId);
    }

    isLoading = false;
    notifyListeners();
  }
}
