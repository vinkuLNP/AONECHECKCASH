import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_network_image.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/cheque_provider.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/app_date_picker.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/app_form_field.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/app_section_tile.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/app_status_chip.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/dropdown_field.dart';
import 'package:flutter/material.dart';
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

      body: Form(
        key: provider.formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            if (!provider.isCreateMode) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSectionTitle(title: AppStrings.status, isPadding: false),
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
              children: [
                Expanded(
                  child: AppFormField(
                    label: AppStrings.customerName,
                    controller: provider.customerNameController,
                    readOnly: provider.isReadOnly,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppFormField(
                    label: AppStrings.customerPhone,
                    controller: provider.customerPhoneController,
                    keyboardType: TextInputType.number,
                    readOnly: provider.isReadOnly,
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
              children: [
                Expanded(
                  child: AppFormField(
                    label: AppStrings.chequeNumber,
                    controller: provider.chequeNumberController,
                    keyboardType: TextInputType.number,
                    readOnly: provider.isReadOnly,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppFormField(
                    label: AppStrings.chequeAmount,
                    controller: provider.amountController,
                    keyboardType: TextInputType.number,
                    readOnly: provider.isReadOnly,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            AppSectionTitle(title: AppStrings.chequeDate),

            AppDatePickerField(
              selectedDate: provider.selectedDate,
              enabled: !provider.isReadOnly,
              onDateSelected: provider.updateDate,
            ),

            const SizedBox(height: 10),

            AppSectionTitle(title: AppStrings.chequeType),

            AppDropdownField<ChequeType>(
              value: provider.type,
              items: ChequeType.values,

              labelBuilder: (type) => type.chequeTypeName,

              onChanged: provider.isReadOnly
                  ? null
                  : (value) {
                      provider.isReadOnly ? null : provider.updateType(value!);
                      if (value != null) {
                        provider.updateType(value);
                      }
                    },
            ),

            const SizedBox(height: 10),

            AppFormField(
              label: AppStrings.payeeName,
              controller: provider.payeeController,
              readOnly: provider.isReadOnly,
            ),
            const SizedBox(height: 20),

            AppSectionTitle(
              title: AppStrings.makerInfo,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: AppFormField(
                    label: AppStrings.makerName,
                    controller: provider.makerNameController,
                    readOnly: provider.isReadOnly,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppFormField(
                    label: AppStrings.makerPhone,
                    controller: provider.makerPhoneController,
                    keyboardType: TextInputType.number,
                    readOnly: provider.isReadOnly,
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
              children: [
                Expanded(
                  child: AppImageBox(
                    title: AppStrings.frontSide,
                    file: provider.frontImage,
                    imageUrl: provider.frontFileId,
                    onTap: provider.isReadOnly
                        ? null
                        : () {
                            provider.pickImage(context, true);
                          },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppImageBox(
                    title: AppStrings.backSide,
                    file: provider.backImage,
                    imageUrl: provider.backFileId,
                    onTap: provider.isReadOnly
                        ? null
                        : () {
                            provider.pickImage(context, false);
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
              maxLength: 500,
              readOnly: provider.isReadOnly,
            ),
            if (!provider.isCreateMode &&
                provider.notesController.text.isNotEmpty &&
                provider.notesController.toString() != "") ...[
              const SizedBox(height: 24),

              AppFormField(
                label: AppStrings.notesComments,
                controller: provider.notesController,
                readOnly: true,
                maxLines: 4,
                maxLength: 500,
              ),
            ],

            const SizedBox(height: 30),

            Row(
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
                            final success = await provider.saveCheque();

                            if (!context.mounted) {
                              return;
                            }

                            if (success) {
                              Navigator.pop(context, true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: AppText(text: AppStrings.saveFailed),
                                ),
                              );
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
    );
  }
}
