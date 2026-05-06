import 'dart:io';

import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';

abstract class ProfileRepository {
  Future<Client> fetchProfile(String clientId);

  Future<bool> updateIdFront(String clientId, String fileId);

  Future<String?> uploadImage(File file, String fieldKey);
}
