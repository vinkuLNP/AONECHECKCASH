import 'dart:io';

import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/create_cheque_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/fetch_cheques_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/update_cheque_usecase.dart';
import 'package:a1_check_cashers/features/upload_image/domain/usecases/upload_image_usecase.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChequeFormProvider extends ChangeNotifier {
  final UploadImageUseCase uploadImageUseCase;
  final CreateChequeUsecase createChequeUsecase;
  final UpdateChequeUsecase updateChequeUsecase;
  final FetchChequesUseCase fetchCheques;

  ChequeFormProvider({
    required this.uploadImageUseCase,
    required this.createChequeUsecase,
    required this.updateChequeUsecase,
    required this.fetchCheques,
  });

  final formKey = GlobalKey<FormState>();

  late TextEditingController chequeNumberController;
  late TextEditingController amountController;
  late TextEditingController companyController;
  late TextEditingController notesController;

  ChequeStatus status = ChequeStatus.underReview;
  ChequeType type = ChequeType.personal;
  DateTime selectedDate = DateTime.now();

  File? frontImage;
  File? backImage;

  String? frontFileId;
  String? backFileId;

  bool isSaving = false;

  void initialize(Cheque? cheque) {
    chequeNumberController = TextEditingController(
      text: cheque?.chequeNumber ?? '',
    );

    amountController = TextEditingController(
      text: cheque?.amount.toString() ?? '',
    );

    companyController = TextEditingController(text: cheque?.companyName ?? '');

    notesController = TextEditingController(text: cheque?.notes ?? '');

    if (cheque != null) {
      status = cheque.status;
      type = cheque.type;
      selectedDate = cheque.chequeDate;

      frontFileId = cheque.frontImage;
      backFileId = cheque.backImage;
    }
  }

  void updateStatus(ChequeStatus value) {
    status = value;
    notifyListeners();
  }

  void updateType(ChequeType value) {
    type = value;
    notifyListeners();
  }

  void updateDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  Future<void> pickImage(BuildContext context, bool isFront) async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final file = File(picked.path);

    if (isFront) {
      frontImage = file;
    } else {
      backImage = file;
    }

    notifyListeners();

    final uploadedFileId = await uploadImageUseCase(
      file,
      isFront ? KnackFields.chequeFrontImage : KnackFields.chequeBackImage,
    );

    if (uploadedFileId == null) return;

    if (isFront) {
      frontFileId = uploadedFileId;
    } else {
      backFileId = uploadedFileId;
    }

    notifyListeners();
  }

  Future<bool> saveCheque() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    notifyListeners();
    if (frontFileId == null || backFileId == null) {
      return false;
    }
    final userId = await SessionManager.getClientRecordId();

    if (userId == null) {
      notifyListeners();
      return false;
    }

    bool success = false;
    isSaving = true;
    notifyListeners();

    success = await createChequeUsecase(
      userId,
      chequeNumberController.text,
      double.parse(amountController.text),
      selectedDate,
      companyController.text,
      frontFileId!,
      backFileId!,
      type,
      AppStrings.underReview,
      notesController.text,
    );
    await loadCheques();
    isSaving = false;

    notifyListeners();

    return success;
  }

  List<Cheque> _cheques = [];

  ChequeStatus? _filterStatus;

  void setFilter(ChequeStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  ChequeStatus? get currentFilter => _filterStatus;

  List<Cheque> get cheques {
    List<Cheque> filtered = _filterStatus == null
        ? [..._cheques]
        : _cheques.where((c) => c.status == _filterStatus).toList();

    filtered.sort(
      (a, b) => a.status.statusPriority.compareTo(b.status.statusPriority),
    );

    return filtered;
  }

  Future<void> loadCheques() async {
    notifyListeners();

    final userId = await SessionManager.getClientRecordId();

    if (userId == null) {
      _cheques = [];
    } else {
      _cheques = await fetchCheques(userId);
    }

    notifyListeners();
  }
}
