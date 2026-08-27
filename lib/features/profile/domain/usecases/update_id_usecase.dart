import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class UpdateIdUseCase {
  final ProfileRepository repo;

  UpdateIdUseCase(this.repo);

  Future<bool> call(String id, String fileId) {
    return repo.updateIdFront(id, fileId);
  }
}
