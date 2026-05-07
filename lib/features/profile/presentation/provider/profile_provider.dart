import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/update_id_usecase.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/upload_id_usecase.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfileUseCase getProfile;
  final UploadIdUseCase uploadId;
  final UpdateIdUseCase updateId;

  ProfileProvider({
    required this.getProfile,
    required this.uploadId,
    required this.updateId,
  });

  Client? user;
  bool isLoading = false;

  Future<void> loadProfile() async {
    final id = await SessionManager.getClientRecordId();
    if (id == null) return;

    isLoading = true;
    notifyListeners();

    user = await getProfile(id);

    isLoading = false;
    notifyListeners();
  }

  Future<void> uploadFrontId(File file) async {
    final fileId =
        await uploadId(file, KnackFields.frontImage);

    if (fileId == null) return;

    final id = await SessionManager.getClientRecordId();
    if (id == null) return;

    await updateId(id, fileId);

    await loadProfile();
  }
}