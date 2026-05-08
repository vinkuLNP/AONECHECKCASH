import 'dart:developer';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/client_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/update_id_usecase.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/upload_id_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
  bool isUploadingId = false;
  Future<void> loadProfile() async {
    final id = await SessionManager.getClientRecordId();
    if (id == null) return;

    try {
      isLoading = true;
      notifyListeners();
      user = await getProfile(id);

      if (user != null) {
        final savedName = await SessionManager.getUserName();

        if (savedName != user!.name) {
          await SessionManager.saveUserName(userName: user!.name);
        }
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> uploadFrontId(File file) async {
    final id = await SessionManager.getClientRecordId();

    if (id == null) return;

    try {
      isUploadingId = true;
      notifyListeners();

      final compressedFile = await compressImage(file);

      final fileId = await uploadId(compressedFile, KnackFields.frontImage);

      if (fileId == null) return;

      await updateId(id, fileId);

      await loadProfile();
    } finally {
      isUploadingId = false;
      notifyListeners();
    }
  }

  Future<File> compressImage(File file) async {
    final targetPath =
        '${file.parent.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
    );

    return File(compressed!.path);
  }

  Future<void> logout(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await SessionManager.clearSession();

      if (!context.mounted) {
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } catch (e) {
      log("Logout Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
