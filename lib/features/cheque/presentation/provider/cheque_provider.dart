import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/core/utils/file_utils.dart';
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

  final TextEditingController chequeNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController chequeDetailsController = TextEditingController();

  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController payeeController = TextEditingController();
  final TextEditingController makerNameController = TextEditingController();
  final TextEditingController makerPhoneController = TextEditingController();
  final TextEditingController otherChequeTypeController =
      TextEditingController();
  ChequeStatus status = ChequeStatus.underReview;
  ChequeType type = ChequeType.personal;
  DateTime selectedDate = DateTime.now();
  bool get isOtherChequeType => type == ChequeType.other;
  final FocusNode customerPhoneFocus = FocusNode();
  final FocusNode makerPhoneFocus = FocusNode();
  final FocusNode customerNameFocus = FocusNode();
  final FocusNode chequeNumberFocus = FocusNode();
  final FocusNode amountFocus = FocusNode();
  final FocusNode payeeFocus = FocusNode();
  final FocusNode makerNameFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();
  final customerNameKey = GlobalKey();
  final customerPhoneKey = GlobalKey();
  final chequeNumberKey = GlobalKey();
  final amountKey = GlobalKey();
  final payeeKey = GlobalKey();
  final makerNameKey = GlobalKey();
  final makerPhoneKey = GlobalKey();
  final chequeDetailsKey = GlobalKey();
  final frontImageKey = GlobalKey();
  final backImageKey = GlobalKey();
  final otherChequeTypeKey = GlobalKey();
  File? frontImage;
  File? backImage;

  String? frontFileId;
  String? frontFileUrl;
  String? backFileUrl;

  String? backFileId;

  bool isSaving = false;
  bool hasSubmitted = false;

  void enableValidation() {
    hasSubmitted = true;
    notifyListeners();
  }
  final ScrollController scrollController = ScrollController();

Future<void> scrollToField(
  GlobalKey key, {
  FocusNode? focusNode,
}) async {
   await WidgetsBinding.instance.endOfFrame;
  final fieldContext = key.currentContext;

  if (fieldContext == null || !fieldContext.mounted) {
    debugPrint('Unable to find field context for $key');
    return;
  }

  await Scrollable.ensureVisible(
    fieldContext,
       duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    alignment: 0.15,

    alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
  );

   if (focusNode != null && focusNode.canRequestFocus) {
    focusNode.requestFocus();
      await Future.delayed(const Duration(milliseconds: 300));

    if (fieldContext.mounted) {
      await Scrollable.ensureVisible(
        fieldContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.15,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    }
  }
}

  void initialize(Cheque? cheque, ChequeFormMode mode) async {
    final userName = await SessionManager.getUserName();
    isLoading = true;
    notifyListeners();
    _cheque = cheque;
    _mode = mode;

    chequeNumberController.text = cheque?.chequeNumber ?? '';

    amountController.text = cheque?.amount == null
        ? ''
        : cheque!.amount % 1 == 0
        ? cheque.amount.toInt().toString()
        : cheque.amount.toString();
    customerNameController.text = cheque?.customerName ?? userName ?? '';

    customerPhoneController.text = cheque?.customerPhone ?? '';

    payeeController.text = cheque?.payee ?? '';

    makerNameController.text = cheque?.makerName ?? '';

    makerPhoneController.text = cheque?.makerPhone ?? '';

    chequeDetailsController.text = cheque?.chequeDetails ?? '';

    notesController.text = cheque?.notes ?? '';

    if (cheque != null) {
      status = cheque.status;
      type = cheque.type;
      selectedDate = cheque.chequeDate;

      frontFileId = cheque.frontImageId;
      backFileId = cheque.backImageId;

      frontFileUrl = cheque.frontImage;
      backFileUrl = cheque.backImage;
      otherChequeTypeController.text = cheque.type == ChequeType.other
          ? cheque.otherChequeType.toString()
          : '';
    }
    isLoading = false;
    notifyListeners();
  }

  String? get safeFrontImage => _cheque?.frontImage;

  String? get safeBackImage => _cheque?.backImage;

  @override
  void dispose() {
      scrollController.dispose();
    customerPhoneFocus.dispose();
    makerPhoneFocus.dispose();
    customerNameFocus.dispose();
    chequeNumberFocus.dispose();
    amountFocus.dispose();
    payeeFocus.dispose();
    makerNameFocus.dispose();
    notesFocus.dispose();
    otherChequeTypeController.dispose();
    chequeNumberController.dispose();
    amountController.dispose();
    notesController.dispose();
    customerNameController.dispose();
    chequeDetailsController.dispose();
    customerPhoneController.dispose();
    payeeController.dispose();
    makerNameController.dispose();
    makerPhoneController.dispose();

    super.dispose();
  }

  void updateType(ChequeType value) {
    type = value;
    if (value != ChequeType.other) {
      otherChequeTypeController.clear();
    }
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
    final isValid = await FileUtils.isValidFileSize(file);

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.errorColor,
          content: AppText(
            text: AppStrings.imageSizeShouldNotExceed,
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
                : AppStrings.uploadBackImageHint,
            color: AppColors.whiteColor,
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
            content: AppText(
              text: AppStrings.failedToUploadImage,
              color: AppColors.whiteColor,
            ),
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
        const SnackBar(
          content: AppText(
            text: AppStrings.failedToUploadImage,
            color: AppColors.whiteColor,
          ),
        ),
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
        "Customer's ${AppStrings.customerPhone}",
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
        "Maker's ${AppStrings.makerPhone}",
      ),

      AppValidators.validateNotes(chequeDetailsController.text),
    ];

    for (final error in validations) {
      if (error != null) {
        return error;
      }
    }
    if (isOtherChequeType && otherChequeTypeController.text.trim().isEmpty) {
      return AppStrings.otherChequeTypeRequired;
    }

    if ((frontFileId?.isEmpty ?? true) || (backFileId?.isEmpty ?? true)) {
      return AppStrings.frontAndBackChequeImagesRequired;
    }

    return null;
  }
  Future<String?> _validateField({
  required BuildContext context,
  required String? error,
  required GlobalKey key,
  FocusNode? focusNode,
}) async {
  if (error == null) return null;

  await scrollToField(
    key,
    focusNode: focusNode,
  );

  return error;
}
Future<String?> validateAndScroll(BuildContext context) async {
  String? error;

  error = await _validateField(
    context: context,
    error: AppValidators.validateName(
      customerNameController.text,
      AppStrings.customerName,
    ),
    key: customerNameKey,
    focusNode: customerNameFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validatePhone(
      customerPhoneController.text,
      "Customer's ${AppStrings.customerPhone}",
    ),
    key: customerPhoneKey,
    focusNode: customerPhoneFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validateChequeNumber(
      chequeNumberController.text,
    ),
    key: chequeNumberKey,
    focusNode: chequeNumberFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validateAmount(
      amountController.text,
    ),
    key: amountKey,
    focusNode: amountFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validateName(
      payeeController.text,
      AppStrings.payeeName,
    ),
    key: payeeKey,
    focusNode: payeeFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validateName(
      makerNameController.text,
      AppStrings.makerName,
    ),
    key: makerNameKey,
    focusNode: makerNameFocus,
  );
  if (error != null) return error;

  error = await _validateField(
    context: context,
    error: AppValidators.validatePhone(
      makerPhoneController.text,
      "Maker's ${AppStrings.makerPhone}",
    ),
    key: makerPhoneKey,
    focusNode: makerPhoneFocus,
  );
  if (error != null) return error;

  if (isOtherChequeType) {
    error = await _validateField(
      context: context,
      error: AppValidators.otherChequeType(
        otherChequeTypeController.text,
        "Cheque Type",
      ),
      key: otherChequeTypeKey,
    );

    if (error != null) return error;
  }

  if (frontFileId == null || frontFileId!.isEmpty) {
    await scrollToField(
      frontImageKey,
    );
    return AppStrings.frontChequeImageRequired;
  }

  if (backFileId == null || backFileId!.isEmpty) {
    await scrollToField(
      backImageKey,
    );
    return AppStrings.backChequeImageRequired;
  }

  error = await _validateField(
    context: context,
    error: AppValidators.validateNotes(
      chequeDetailsController.text,
    ),
    key: chequeDetailsKey,
    focusNode: notesFocus,
  );
  if (error != null) return error;

  return null;
}
  Future<bool> saveCheque(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final frontImageId = frontFileId;
    final backImageId = backFileId;
    enableValidation();

    final isValid = formKey.currentState!.validate();
      await WidgetsBinding.instance.endOfFrame;
    final firstError = await validateAndScroll(context);


    if (!isValid || firstError != null) {
       if (!context.mounted) return false;
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

    if (frontImageId == null || backImageId == null) {
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
        frontImageId,
        backImageId,
        type == ChequeType.other
            ? otherChequeTypeController.text.trim()
            : type.chequeTypeName,
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
        frontImageId,
        backImageId,
        type == ChequeType.other
            ? otherChequeTypeController.text.trim()
            : type.chequeTypeName,
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

  ChequeFormMode _mode = ChequeFormMode.create;
  bool get checkStatusNeedMoreInfo => status == ChequeStatus.needMoreInfo;
  ChequeFormMode get mode => _mode;
  bool get isEditMode =>
      _mode == ChequeFormMode.edit && checkStatusNeedMoreInfo;
  bool get isCreateMode => _mode == ChequeFormMode.create;
  bool get isViewMode => _mode == ChequeFormMode.view;
  bool get isReadOnly => isViewMode;
  Cheque? _cheque;

  void switchToEditMode() {
    if (_mode == ChequeFormMode.view) {
      _mode = ChequeFormMode.edit;
      notifyListeners();
    }
  }
}
