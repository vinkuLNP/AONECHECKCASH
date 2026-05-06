import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.name,
    required super.email,
    super.idFrontImage,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    String name = '';
    final nameRaw = json['field_30_raw'];

    if (nameRaw is Map) {
      name = nameRaw['full'] ?? '';
    } else if (json['field_30'] is String) {
      name = json['field_30'];
    }

    String email = '';
    final emailRaw = json['field_31_raw'];

    if (emailRaw is Map) {
      email = emailRaw['email'] ?? '';
    }

    String? image;
    final imageRaw = json['field_65_raw'];

    if (imageRaw is Map) {
      image = imageRaw['url'];
    } else if (imageRaw is List && imageRaw.isNotEmpty) {
      image = imageRaw.first['url'];
    }

    return ClientModel(
      id: json['id'].toString(),
      name: name,
      email: email,
      idFrontImage: image,
    );
  }
}
