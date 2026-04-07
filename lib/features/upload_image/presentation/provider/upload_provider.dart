import 'dart:io';

import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/create_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/delete_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/fetch_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/update_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/upload_image_usecase.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  final UploadImageUseCase uploadImage;
  final CreateDocumentUseCase createDoc;
  final FetchDocumentsUseCase fetchDocs;
  final UpdateDocumentsUseCase updateDoc;
  final DeleteDocumentUseCase deleteDoc;

  UploadProvider({
    required this.uploadImage,
    required this.createDoc,
    required this.fetchDocs,
    required this.updateDoc,
    required this.deleteDoc,
  });

  List<Item> items = [];
  bool isLoading = false;

  Future<void> loadDocuments() async {
    isLoading = true;
    notifyListeners();
    final userId = await SessionManager.getUserId();
    if (userId == null) {
      items = [];
    } else {
      items = await fetchDocs(userId);
    }

    isLoading = false;
    notifyListeners();
  }

  // Future<bool> saveDocument({
  //   String? id,
  //   required String description,
  //   File? image,
  //   String? existingImage,
  // }) async {
  //   isLoading = true;
  //   notifyListeners();

  //   final userId = await SessionManager.getUserId();

  //   if (userId == null) {
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }

  //   String? fileId = existingImage;

  //   if (image != null) {
  //     fileId = await uploadImage(image);
  //   }

  //   bool success;

  //  if (id != null) {
  //   // ✅ UPDATE EXISTING DOCUMENT
  //   success = await createDoc.updateDocument(
  //     id,
  //     description,
  //     fileId ?? "",
  //   );
  // } else {
  //   // ✅ CREATE NEW DOCUMENT
  //   success = await createDoc(
  //     description,
  //     fileId ?? "",
  //     userId,
  //   );
  // }

  //   await loadDocuments();

  //   isLoading = false;
  //   notifyListeners();

  //   return success;
  // }
  Future<bool> saveDocument({
    String? id,
    required String description,
    File? image,
    String? existingFileId,
  }) async {
    isLoading = true;
    notifyListeners();

    final userId = await SessionManager.getUserId();

    if (userId == null) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    String? fileId;

    /// 🔥 If new image selected → upload
    if (image != null) {
      fileId = await uploadImage(image);
    }

    /// 🔥 If editing & no new image → KEEP OLD FILE ID
    if (image == null && existingFileId != null) {
      fileId =existingFileId; // 👈 IMPORTANT
    }

    bool success;

    if (id != null) {
      /// ✅ UPDATE
      success = await updateDoc(id, description, fileId ?? "");
    } else {
      /// ✅ CREATE
      success = await createDoc(description, fileId ?? "", userId);
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
}
