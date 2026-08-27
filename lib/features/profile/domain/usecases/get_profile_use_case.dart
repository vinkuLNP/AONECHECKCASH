import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repo;

  GetProfileUseCase(this.repo);

  Future<Client> call(String id) => repo.fetchProfile(id);
}
