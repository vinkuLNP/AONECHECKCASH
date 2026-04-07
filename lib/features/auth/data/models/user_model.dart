import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final session = json['session'];
    final user = session['user'];
    final values = user['values'];

    return UserModel(
      id: user['id'].toString(),

      email: values['email']?['email']?.toString() ?? '',
      token: session['token'].toString(),
    );
  }
}
