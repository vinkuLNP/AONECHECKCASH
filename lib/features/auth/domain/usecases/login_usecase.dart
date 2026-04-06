import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';
import 'package:a1_check_cashers/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}