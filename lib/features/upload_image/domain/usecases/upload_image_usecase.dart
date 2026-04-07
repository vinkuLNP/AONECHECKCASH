import 'dart:io';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UploadImageUseCase {
  final UploadRepository repo;
  UploadImageUseCase(this.repo);

  Future<String?> call(File file) => repo.uploadImage(file);
}

