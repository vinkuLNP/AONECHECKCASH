import 'dart:io';

import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/create_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/fetch_document_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/upload_image_usecase.dart';
import 'package:flutter/material.dart';
class UploadProvider extends ChangeNotifier {
  final UploadImageUseCase uploadImage;
  final CreateDocumentUseCase createDoc;
  final FetchDocumentsUseCase fetchDocs;

  UploadProvider({
    required this.uploadImage,
    required this.createDoc,
    required this.fetchDocs,
  });

  List<Item> items = [];
  bool isLoading = false;

  Future<void> loadDocuments() async {
    isLoading = true;
    notifyListeners();

    items = await fetchDocs();

    isLoading = false;
    notifyListeners();
  }

  Future<bool> saveDocument({
    String? id, 
    required String description,
    File? image,
    String? existingImage,
  }) async {
    isLoading = true;
    notifyListeners();

    String? fileId = existingImage;

    if (image != null) {
      fileId = await uploadImage(image);
    }

    bool success;

    if (id != null) {
      success = await createDoc(description, fileId ?? "");
    } else {
      success = await createDoc(description, fileId ?? "");
    }

    await loadDocuments();

    isLoading = false;
    notifyListeners();

    return success;
  }

  void delete(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}