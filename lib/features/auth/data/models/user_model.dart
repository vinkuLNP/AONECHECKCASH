import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
import 'package:a1_check_cashers/features/auth/domain/enitities/user_entity.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.token,
    required super.clientRecordId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final session = json['session'];
    final user = session['user'];
    final values = user['values'];
    final profileObjects = user['profile_objects'];
    String clientRecordId = '';

    if (profileObjects != null && profileObjects is List) {
      for (var obj in profileObjects) {
        if (obj['object'] == objectKeyUsers) {
          clientRecordId = obj['entry_id'].toString();
          break;
        }
      }
    }

    return UserModel(
      id: user['id'].toString(),
      email: values['email']?['email']?.toString() ?? '',
      token: session['token'].toString(),
      clientRecordId: clientRecordId,
    );
  }
}
