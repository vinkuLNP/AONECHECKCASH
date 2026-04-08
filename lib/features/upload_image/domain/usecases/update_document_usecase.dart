import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UpdateDocumentsUseCase {
  final UploadRepository repo;
  UpdateDocumentsUseCase(this.repo);

  Future<bool> call(String docId, String description, String fileId) =>
      repo.updateDocument(docId, description, fileId);
}
