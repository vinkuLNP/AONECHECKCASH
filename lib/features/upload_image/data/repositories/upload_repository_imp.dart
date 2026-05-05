import 'dart:io';

import 'package:a1_check_cashers/features/upload_image/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource remote;

  UploadRepositoryImpl(this.remote);

  @override
  Future<String?> uploadImage(File file, String fieldKey) {
    return remote.uploadImage(file, fieldKey);
  }

  @override
  Future<bool> createDocument(String description, String frontFileId, String backFileId, String userId) {
    return remote.createDocument(description, frontFileId, backFileId, userId);
  }

  @override
  Future<List<Item>> fetchDocuments(String userId) async {
    return await remote.fetchDocuments(userId);
  }
   @override
  Future<bool> updateDocument(String docId, String description, String frontFileId, String backFileId) {
    return remote.updateDocument(docId, description, frontFileId, backFileId);
  } 
  @override
  Future<bool> deleteDocuments(String docId) {
    return remote.deleteDocument(docId);
  }
 
}