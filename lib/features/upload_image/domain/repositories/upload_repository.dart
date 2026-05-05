import 'dart:io';

import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';

abstract class UploadRepository {
  Future<String?> uploadImage(File file, String fieldKey);
  Future<bool> createDocument(String description, String frontFileId, String backFileId, String userId);
  Future<List<Item>> fetchDocuments(String userId);
  Future<bool> deleteDocuments(String docId);
  Future<bool> updateDocument(String docId, String description, String frontFileId, String backFileId);
}
