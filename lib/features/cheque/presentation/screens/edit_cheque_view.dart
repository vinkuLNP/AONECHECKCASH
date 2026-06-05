import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_card.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_keys.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/cheque/presentation/validator/check_form_validator.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_date_picker.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_form_field.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_section_tile.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_status_chip.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditChequeView extends StatelessWidget {
  const EditChequeView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChequeFormProvider>();

    return Scaffold(
      backgroundColor: AppColors.heroColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.heroColor,
        foregroundColor: AppColors.primary.withValues(alpha: .8),
        centerTitle: true,
        title: AppText(
          text: provider.isEditMode
              ? AppStrings.editCheque
              : provider.isReadOnly
              ? AppStrings.viewCheque
              : AppStrings.addCheque,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: provider.isSaving,
            child: Opacity(
              opacity: provider.isSaving ? 0.5 : 1,
              child: Form(
                key: provider.formKey,

                child: ListView(
                  padding: const EdgeInsets.all(16),

                  children: [
                    if (!provider.isCreateMode) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppSectionTitle(
                            title: AppStrings.status,
                            isPadding: false,
                          ),
                          const SizedBox(width: 20),

                          AppStatusChip(
                            title: provider.status.status,
                            icon: provider.status.statusIcon,
                            color: provider.status.statusColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                    AppSectionTitle(
                      title: AppStrings.customerInfo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: AppFormField(
                            label: AppStrings.customerName,
                            controller: provider.customerNameController,
                            readOnly: provider.isReadOnly,
                            focusNode: provider.customerNameFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            maxLength: 50,
                            validator: (value) => AppValidators.validateName(
                              value,
                              AppStrings.customerName,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                AppKeys.charactersOnlyFormatter,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: AppFormField(
                            label: AppStrings.customerPhone,
                            controller: provider.customerPhoneController,
                            keyboardType: TextInputType.number,
                            focusNode: provider.customerPhoneFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            readOnly: provider.isReadOnly,
                            maxLength: 10,
                            validator: (value) => AppValidators.validatePhone(
                              value,
                              AppStrings.customerPhone,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    AppSectionTitle(
                      title: AppStrings.chequeInfo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: AppFormField(
                            label: AppStrings.chequeNumber,
                            controller: provider.chequeNumberController,
                            keyboardType: TextInputType.number,
                            readOnly: provider.isReadOnly,
                            focusNode: provider.chequeNumberFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            maxLength: 15,
                            validator: AppValidators.validateChequeNumber,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(15),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: AppFormField(
                            label: AppStrings.chequeAmount,
                            controller: provider.amountController,
                            keyboardType: TextInputType.number,
                            readOnly: provider.isReadOnly,
                            focusNode: provider.amountFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            maxLength: 15,
                            validator: AppValidators.validateAmount,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                AppKeys.digitsAndDecimalFormatter,
                              ),
                              LengthLimitingTextInputFormatter(15),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    AppSectionTitle(
                      title: AppStrings.chequeDate,
                      titleColor: AppColors.black,
                    ),

                    AppDatePickerField(
                      selectedDate: provider.selectedDate,
                      enabled: !provider.isReadOnly,
                      onDateSelected: provider.updateDate,
                    ),

                    const SizedBox(height: 10),

                    AppSectionTitle(
                      title: AppStrings.chequeType,
                      titleColor: AppColors.black,
                    ),

                    AppDropdownField<ChequeType>(
                      value: provider.type,
                      items: ChequeType.values,

                      labelBuilder: (type) => type.chequeTypeName,

                      onChanged: provider.isReadOnly
                          ? null
                          : (value) {
                              if (value != null) {
                                provider.updateType(value);
                              }
                            },
                    ),
                    if (provider.isOtherChequeType) ...[
                      const SizedBox(height: 12),

                      AppFormField(
                        label: 'Enter cheque type',
                        controller: provider.otherChequeTypeController,
                        readOnly: provider.isReadOnly,
                        autovalidateMode: provider.hasSubmitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,

                        validator: (value) =>
                            AppValidators.otherChequeType(value, 'cheque type'),
                      ),
                    ],
                    const SizedBox(height: 10),

                    AppFormField(
                      label: AppStrings.payeeName,
                      controller: provider.payeeController,
                      readOnly: provider.isReadOnly,
                      focusNode: provider.payeeFocus,
                      autovalidateMode: provider.hasSubmitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      maxLength: 50,
                      validator: (value) => AppValidators.validateName(
                        value,
                        AppStrings.payeeName,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          AppKeys.charactersOnlyFormatter,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    AppSectionTitle(
                      title: AppStrings.makerInfo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppFormField(
                            label: AppStrings.makerName,
                            focusNode: provider.makerNameFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            controller: provider.makerNameController,
                            readOnly: provider.isReadOnly,
                            maxLength: 50,
                            validator: (value) => AppValidators.validateName(
                              value,
                              AppStrings.makerName,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                AppKeys.charactersOnlyFormatter,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: AppFormField(
                            label: AppStrings.makerPhone,
                            controller: provider.makerPhoneController,
                            keyboardType: TextInputType.number,
                            readOnly: provider.isReadOnly,
                            focusNode: provider.makerPhoneFocus,
                            autovalidateMode: provider.hasSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            maxLength: 10,
                            validator: (value) => AppValidators.validatePhone(
                              value,
                              AppStrings.makerPhone,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AppSectionTitle(
                      title: AppStrings.chequeImages,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: AppImagePickerCard(
                            title: AppStrings.frontSide,
                            file: provider.frontImage,
                            titleColor: AppColors.black,
                            imageUrl: provider.safeFrontImage,
                            isLoading: provider.isUploadingFront,
                            readOnly:
                                provider.isReadOnly ||
                                provider.isAnyImageUploading,
                            errorText:
                                provider.hasSubmitted &&
                                    provider.frontFileId == null
                                ? 'Front cheque image is required'
                                : null,
                            onImageSelected: (file) async {
                              await provider.uploadChequeImage(
                                file,
                                true,
                                context,
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: AppImagePickerCard(
                            title: AppStrings.backSide,
                            file: provider.backImage,
                            titleColor: AppColors.black,
                            errorText:
                                provider.hasSubmitted &&
                                    provider.backFileId == null
                                ? 'Back cheque image is required'
                                : null,
                            imageUrl: provider.safeBackImage,
                            isLoading: provider.isUploadingBack,
                            readOnly:
                                provider.isReadOnly ||
                                provider.isAnyImageUploading,
                            onImageSelected: (file) async {
                              await provider.uploadChequeImage(
                                file,
                                false,
                                context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    AppFormField(
                      label: AppStrings.additionalNotes,
                      controller: provider.chequeDetailsController,
                      maxLines: null,
                      minLines: 5,
                      focusNode: provider.notesFocus,
                      autovalidateMode: provider.hasSubmitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      maxLength: 500,
                      readOnly: provider.isReadOnly,
                      validator: AppValidators.validateNotes,
                    ),
                    if (!provider.isCreateMode &&
                        provider.notesController.text.isNotEmpty &&
                        provider.notesController.toString() != "") ...[
                      const SizedBox(height: 24),

                      AppFormField(
                        label: AppStrings.notesComments,
                        controller: provider.notesController,
                        readOnly: true,
                      ),
                    ],

                    const SizedBox(height: 30),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: AppButton(
                            text: AppStrings.cancel,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            textColor: AppColors.primary,
                            isOutlined: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: provider.isEditMode
                                ? AppStrings.update
                                : AppStrings.saveCheque,
                            onPressed: provider.isReadOnly
                                ? null
                                : provider.isSaving
                                ? null
                                : () async {
                                    final success = await provider.saveCheque(
                                      context,
                                    );

                                    if (!context.mounted) {
                                      return;
                                    }

                                    if (success && context.mounted) {
                                      await context
                                          .read<ChequeFormProvider>()
                                          .loadCheques();

                                      Navigator.pop(context, true);
                                    }
                                  },
                            textColor: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          if (provider.isSaving)
            Container(
              color: Colors.black.withValues(alpha: 0.2),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
