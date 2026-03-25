import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';
import 'package:a1_check_cashers/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<User> call(String email, String password, String name) {
    return repository.signup(email, password, name);
  }
}
