import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class CreateDocumentUseCase {
  final UploadRepository repo;
  CreateDocumentUseCase(this.repo);

  Future<bool> call(String desc, String fileId,String userId) =>
      repo.createDocument(desc, fileId,userId);
}
