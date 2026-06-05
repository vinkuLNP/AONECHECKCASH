import 'dart:developer';
import 'dart:io';

import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/profile/domain/enitites/business_check_cashing_entity.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/upload_business_form_usecase.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCheckProvider extends ChangeNotifier {
  final UploadBusinessFormUsecase uploadUsecase;
  final FetchBusinessFormUsecase fetchUsecase;
  final CreateBusinessFormUsecase createUsecase;
  final UpdateBusinessFormUsecase updateUsecase;
  final DownloadEmptyFormUsecase downloadUsecase;

  BusinessCheckProvider({
    required this.uploadUsecase,
    required this.fetchUsecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.downloadUsecase,
  });

  BusinessCheckFormEntity? form;

  bool isLoading = false;
  bool isUploading = false;

  Future<void> loadForm() async {
    final clientId = await SessionManager.getClientRecordId();

    if (clientId == null) return;

    try {
      isLoading = true;
      notifyListeners();

      form = await fetchUsecase(clientId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> downloadEmptyForm() async {
    final url = await downloadUsecase();

    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }


  Future<void> uploadBusinessForm(File file) async {
    final clientId = await SessionManager.getClientRecordId();

    if (clientId == null) {
      log("Client ID is null");
      return;
    }

    try {
      isUploading = true;

      notifyListeners();

      log("========== BUSINESS FORM UPLOAD ==========");
      log("Client ID: $clientId");
      log("Selected File: ${file.path}");

      final fileId = await uploadUsecase(file, KnackFields.applicationForm);

      log("Received File ID: $fileId");

      if (fileId == null) {
        log("File Upload Failed");

        return;
      }

      bool success = false;

      // if (form == null) {
      log("Creating New Form Record");

      success = await createUsecase(clientId: clientId, fileId: fileId);
      // } else {
      //   log("Updating Existing Form");
      //   log("Record ID: ${form!.id}");

      //   success = await updateUsecase(
      //     recordId: form!.id,
      //     fileId: fileId,
      //   );
      // }

      log("Create/Update Success: $success");

      await loadForm();

      log("Latest Form Loaded");
      log("Current File URL: ${form?.fileUrl}");

      log("========== BUSINESS FORM DONE ==========");
    } catch (e) {
      log("Business Form Upload Error: $e");
    } finally {
      isUploading = false;

      notifyListeners();
    }
  }
}
