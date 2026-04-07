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
  Future<bool> createDocument(String description, String fileId) {
    return remote.createDocument(description, fileId);
  }

  @override
  Future<List<Item>> fetchDocuments() async {
    return await remote.fetchDocuments();
  }
}