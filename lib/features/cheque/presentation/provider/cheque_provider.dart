import 'dart:io';

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/features/cheque/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_form_mode_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/create_cheque_usecase.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/fetch_cheques_usecase.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/update_cheque_usecase.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/upload_image_usecase.dart';
import 'package:a1_check_cashers/features/cheque/presentation/validator/check_form_validator.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;
  bool get isAnyImageUploading => isUploadingFront || isUploadingBack;
  final formKey = GlobalKey<FormState>();

  late TextEditingController chequeNumberController;
  late TextEditingController amountController;
  late TextEditingController notesController;
  late TextEditingController customerNameController;
  late TextEditingController chequeDetailsController;

  late TextEditingController customerPhoneController;
  late TextEditingController payeeController;
  late TextEditingController makerNameController;
  late TextEditingController makerPhoneController;
  ChequeStatus status = ChequeStatus.underReview;
  ChequeType type = ChequeType.personal;
  DateTime selectedDate = DateTime.now();
  late FocusNode customerPhoneFocus;
  late FocusNode makerPhoneFocus;
  late FocusNode customerNameFocus;
  late FocusNode chequeNumberFocus;
  late FocusNode amountFocus;
  late FocusNode payeeFocus;
  late FocusNode makerNameFocus;
  late FocusNode notesFocus;
  File? frontImage;
  File? backImage;

  String? frontFileId;
  String? backFileId;

  bool isSaving = false;
  bool hasSubmitted = false;

  void enableValidation() {
    hasSubmitted = true;
    notifyListeners();
  }

  void initialize(Cheque? cheque, ChequeFormMode mode) {
    isLoading = true;
    notifyListeners();
    _cheque = cheque;
    _mode = mode;
    chequeNumberController = TextEditingController(
      text: cheque?.chequeNumber ?? '',
    );

    amountController = TextEditingController(
      text: cheque?.amount.toString() ?? '',
    );

    customerNameController = TextEditingController(
      text: cheque?.customerName ?? '',
    );

    customerPhoneController = TextEditingController(
      text: cheque?.customerPhone ?? '',
    );

    payeeController = TextEditingController(text: cheque?.payee ?? '');

    makerNameController = TextEditingController(text: cheque?.makerName ?? '');

    makerPhoneController = TextEditingController(
      text: cheque?.makerPhone ?? '',
    );

    chequeDetailsController = TextEditingController(
      text: cheque?.chequeDetails ?? '',
    );

    notesController = TextEditingController(text: cheque?.notes ?? '');

    if (cheque != null) {
      status = cheque.status;
      type = cheque.type;
      selectedDate = cheque.chequeDate;

      frontFileId = cheque.frontImage;
      backFileId = cheque.backImage;
    }
    customerPhoneFocus = FocusNode();
    makerPhoneFocus = FocusNode();
    customerNameFocus = FocusNode();
    chequeNumberFocus = FocusNode();
    amountFocus = FocusNode();
    payeeFocus = FocusNode();
    makerNameFocus = FocusNode();
    notesFocus = FocusNode();

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    customerPhoneFocus.dispose();
    makerPhoneFocus.dispose();
    customerNameFocus.dispose();
    chequeNumberFocus.dispose();
    amountFocus.dispose();
    payeeFocus.dispose();
    makerNameFocus.dispose();
    notesFocus.dispose();

    super.dispose();
  }

  void updateType(ChequeType value) {
    type = value;
    notifyListeners();
  }

  void updateDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  bool isUploadingFront = false;
  bool isUploadingBack = false;
  Future<void> uploadChequeImage(
    File file,
    bool isFront,
    BuildContext context,
  ) async {
    if (isAnyImageUploading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.errorColor,
          content: AppText(
            text: AppStrings.pleaseWaitForCurrentUpload,
            color: AppColors.whiteColor,
          ),
        ),
      );

      return;
    }

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.errorColor,
          duration: const Duration(seconds: 1),
          content: AppText(
            text: isFront
                ? AppStrings.uploadFrontImageHint
                : AppStrings.uploadBackImageHint,color: AppColors.whiteColor,
          ),
        ),
      );
      if (isFront) {
        isUploadingFront = true;
        frontImage = file;
      } else {
        isUploadingBack = true;
        backImage = file;
      }

      notifyListeners();
      final uploadedFileId = await uploadImageUseCase(
        file,
        isFront ? KnackFields.chequeFrontImage : KnackFields.chequeBackImage,
      );

      if (uploadedFileId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.errorColor,
            content: AppText(text: AppStrings.failedToUploadImage,color: AppColors.whiteColor,),
          ),
        );

        return;
      }

      if (isFront) {
        frontFileId = uploadedFileId;
      } else {
        backFileId = uploadedFileId;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: AppText(
            text: isFront
                ? AppStrings.frontImageUploadedSuccessfully
                : AppStrings.backImageUploadedSuccessfully,
            color: AppColors.whiteColor,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: AppText(text: AppStrings.failedToUploadImage,color: AppColors.whiteColor,)),
      );
    } finally {
      if (isFront) {
        isUploadingFront = false;
      } else {
        isUploadingBack = false;
      }
      notifyListeners();
    }
  }

  String? getFirstValidationError() {
    final validations = [
      AppValidators.validateName(
        customerNameController.text,
        AppStrings.customerName,
      ),

      AppValidators.validatePhone(
        customerPhoneController.text,
        AppStrings.customerPhone,
      ),

      AppValidators.validateChequeNumber(chequeNumberController.text),

      AppValidators.validateAmount(amountController.text),

      AppValidators.validateName(payeeController.text, AppStrings.payeeName),

      AppValidators.validateName(
        makerNameController.text,
        AppStrings.makerName,
      ),

      AppValidators.validatePhone(
        makerPhoneController.text,
        AppStrings.makerPhone,
      ),

      AppValidators.validateNotes(chequeDetailsController.text),
    ];

    for (final error in validations) {
      if (error != null) {
        return error;
      }
    }

    if (frontFileId == null || backFileId == null) {
      return 'Front and back cheque images are required';
    }

    return null;
  }

  Future<bool> saveCheque(BuildContext context) async {
    FocusScope.of(context).unfocus();

    enableValidation();

    await Future.delayed(const Duration(milliseconds: 100));

    final firstError = getFirstValidationError();

    final isValid = formKey.currentState!.validate();

    if (!isValid || firstError != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            text: firstError ?? AppStrings.smthngWntWrong,
            color: AppColors.whiteColor,
          ),
        ),
      );

      return false;
    }

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
    isLoading = true;
    notifyListeners();
    if (!isEditMode) {
      success = await createChequeUsecase(
        userId,
        chequeNumberController.text,
        double.parse(amountController.text),
        selectedDate,
        frontFileId!,
        backFileId!,
        type,
        customerNameController.text,
        customerPhoneController.text,
        payeeController.text,
        makerNameController.text,
        makerPhoneController.text,
        chequeDetailsController.text,
        AppStrings.underReview,
        notesController.text,
      );
    } else {
      success = await updateChequeUsecase(
        _cheque!.id,
        chequeNumberController.text,
        double.parse(amountController.text),
        selectedDate,
        frontFileId!,
        backFileId!,
        type,
        customerNameController.text,
        customerPhoneController.text,
        payeeController.text,
        makerNameController.text,
        makerPhoneController.text,
        chequeDetailsController.text,
        status.status,
        notesController.text,
      );
    }
    await loadCheques();
    isSaving = false;
    isLoading = false;
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
    isLoading = true;
    notifyListeners();

    final userId = await SessionManager.getClientRecordId();

    if (userId == null) {
      _cheques = [];
    } else {
      _cheques = await fetchCheques(userId);
    }

    isLoading = false;
    notifyListeners();
  }

  Map<ChequeStatus, List<Cheque>> get groupedCheques {
    final Map<ChequeStatus, List<Cheque>> map = {};

    for (var cheque in _cheques) {
      map.putIfAbsent(cheque.status, () => []).add(cheque);
    }

    return map;
  }

  late ChequeFormMode _mode;

  bool get isEditMode => _mode == ChequeFormMode.edit;
  bool get isCreateMode => _mode == ChequeFormMode.create;
  bool get isViewMode => _mode == ChequeFormMode.view;
  bool get isReadOnly => _mode == ChequeFormMode.view;

  Cheque? _cheque;
}
