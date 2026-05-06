import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class DeleteDocumentUseCase {
  final UploadRepository repo;
  DeleteDocumentUseCase(this.repo);

  Future<void> call(String id) => repo.deleteDocuments(id);
}
