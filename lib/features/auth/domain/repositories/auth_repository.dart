import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> signup(String email, String password, String name);
}
