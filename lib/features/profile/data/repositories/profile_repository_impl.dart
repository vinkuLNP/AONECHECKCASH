import 'dart:io';

import 'package:a1_check_cashers/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/business_check_cashing_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Client> fetchProfile(String clientId) {
    return remote.fetchProfile(clientId);
  }

  @override
  Future<bool> updateIdFront(String clientId, String fileId) {
    return remote.updateUserIdFront(clientId: clientId, fileId: fileId);
  }

  @override
  Future<String?> uploadImage(File file, String fieldKey) {
    return remote.uploadImage(file, fieldKey);
  }

  @override
  Future<String?> uploadForm(File file, String fieldKey) {
    return remote.uploadForm(file, fieldKey);
  }

  @override
  Future<bool> createForm({
    required String clientId,
    required String fileId,
  }) {
    return remote.createForm(clientId: clientId, fileId: fileId);
  }

  @override
  Future<bool> updateForm({
    required String recordId,
    required String fileId,
  }) {
    return remote.updateForm(recordId: recordId, fileId: fileId);
  }

  @override
  Future<BusinessCheckFormEntity?> fetchForm(String clientId) {
    return remote.fetchForm(clientId);
  }

  @override
  Future<String> downloadEmptyForm() {
    return remote.downloadEmptyForm();
  }
}
