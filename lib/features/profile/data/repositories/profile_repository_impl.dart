import 'dart:io';

import 'package:a1_check_cashers/features/profile/data/data_source/profile_remote_data_source.dart';
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
}
