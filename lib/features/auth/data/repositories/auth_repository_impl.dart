import 'package:a1_check_cashers/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<User> signup(String email, String password, String name) {
    return remote.signup(email, password, name);
  }
}
