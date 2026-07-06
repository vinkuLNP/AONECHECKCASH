import 'dart:io';

import 'package:a1_check_cashers/features/profile/domain/enitites/business_check_cashing_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class UploadBusinessFormUsecase {
  final ProfileRepository repo;

  UploadBusinessFormUsecase(this.repo);

  Future<String?> call(File file, String fieldKey) =>
      repo.uploadForm(file, fieldKey);
}

class FetchBusinessFormUsecase {
  final ProfileRepository repo;

  FetchBusinessFormUsecase(this.repo);

  Future<BusinessCheckFormEntity?> call(String clientId) =>
      repo.fetchForm(clientId);
}

class CreateBusinessFormUsecase {
  final ProfileRepository repo;

  CreateBusinessFormUsecase(this.repo);

  Future<bool> call({required String clientId, required String fileId}) =>
      repo.createForm(clientId: clientId, fileId: fileId);
}

class UpdateBusinessFormUsecase {
  final ProfileRepository repo;

  UpdateBusinessFormUsecase(this.repo);

  Future<bool> call({required String recordId, required String fileId}) =>
      repo.updateForm(recordId: recordId, fileId: fileId);
}

class DownloadEmptyFormUsecase {
  final ProfileRepository repo;

  DownloadEmptyFormUsecase(this.repo);

  Future<String> call() => repo.downloadEmptyForm();
}
