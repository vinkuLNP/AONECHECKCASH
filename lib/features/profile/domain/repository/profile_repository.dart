import 'dart:io';
import 'package:a1_check_cashers/features/profile/domain/enitites/business_check_cashing_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';

abstract class ProfileRepository {
  Future<Client> fetchProfile(String clientId);

  Future<bool> updateIdFront(String clientId, String fileId);

  Future<String?> uploadImage(File file, String fieldKey);

  Future<String?> uploadForm(File file, String fieldKey);

  Future<bool> createForm({required String clientId, required String fileId});

  Future<bool> updateForm({required String recordId, required String fileId});

  Future<BusinessCheckFormEntity?> fetchForm(String clientId);

  Future<String> downloadEmptyForm();
}
