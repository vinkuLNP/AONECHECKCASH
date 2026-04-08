import 'dart:io';

import 'package:a1_check_cashers/features/upload_image/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource remote;

  UploadRepositoryImpl(this.remote);

  @override
  Future<String?> uploadImage(File file) {
    return remote.uploadImage(file);
  }

  @override
  Future<bool> createDocument(String description, String fileId,String userId) {
    return remote.createDocument(description, fileId,userId);
  }

  @override
  Future<List<Item>> fetchDocuments(String userId) async {
    return await remote.fetchDocuments(userId);
  }
   @override
  Future<bool> updateDocument(String docId, String description, String fileId) {
    return remote.updateDocument(docId, description, fileId);
  } 
  @override
  Future<bool> deleteDocuments(String docId) {
    return remote.deleteDocument(docId);
  }
 
}