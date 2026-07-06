import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class DeleteUserUseCase {
  final ProfileRepository repo;

  DeleteUserUseCase(this.repo);

  Future<bool> call(String clientId) {
    return repo.deleteUser(clientId: clientId);
  }
}
