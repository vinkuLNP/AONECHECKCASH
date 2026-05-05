import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class FetchChequesUseCase {
  final UploadRepository repo;
  FetchChequesUseCase(this.repo);

  Future<List<Cheque>> call(String userId) => repo.fetchCheques(userId);
}