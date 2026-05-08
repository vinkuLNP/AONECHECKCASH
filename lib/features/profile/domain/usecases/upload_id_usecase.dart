import 'dart:io';

import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class UploadIdUseCase {
  final ProfileRepository repo;

  UploadIdUseCase(this.repo);

  Future<String?> call(File file, String fieldKey) {
    return repo.uploadImage(file, fieldKey);
  }
}
