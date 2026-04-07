

import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class FetchDocumentsUseCase {
  final UploadRepository repo;
  FetchDocumentsUseCase(this.repo);

  Future<List<Item>> call() => repo.fetchDocuments();
}