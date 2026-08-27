import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/core/utils/app_logger.dart';
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
      return;
    }

    try {
      isUploading = true;

      notifyListeners();

      final fileId = await uploadUsecase(file, KnackFields.applicationForm);

      if (fileId == null) {
        return;
      }

      await createUsecase(clientId: clientId, fileId: fileId);

      await loadForm();
    } catch (e) {
      AppLogger.error(e);
    } finally {
      isUploading = false;

      notifyListeners();
    }
  }
}
