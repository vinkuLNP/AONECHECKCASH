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
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/dropdown_field.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/widgets/status_chip.dart';
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
        title: const AppText(
          text: AppStrings.editCheque,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: Form(
        key: provider.formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            AppSectionTitle(title: AppStrings.status),
            statusChip(status: provider.status.status),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AppFormField(
                    label: AppStrings.chequeNumber,
                    controller: provider.chequeNumberController,
                    keyboardType: TextInputType.number,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AppFormField(
                    label: AppStrings.chequeAmount,
                    controller: provider.amountController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            AppSectionTitle(title: AppStrings.chequeDate),

            AppDatePickerField(
              selectedDate: provider.selectedDate,

              onDateSelected: provider.updateDate,
            ),

            const SizedBox(height: 20),

            AppSectionTitle(title: AppStrings.chequeType),

            AppDropdownField<ChequeType>(
              value: provider.type,
              items: ChequeType.values,

              labelBuilder: (type) => type.chequeTypeName,

              onChanged: (value) {
                if (value != null) {
                  provider.updateType(value);
                }
              },
            ),

            const SizedBox(height: 20),

            AppFormField(
              label: AppStrings.companyName,
              controller: provider.companyController,
            ),

            const SizedBox(height: 24),

            AppSectionTitle(title: AppStrings.chequeImages),

            Row(
              children: [
                Expanded(
                  child: AppImageBox(
                    title: AppStrings.frontSide,
                    file: provider.frontImage,
                    imageUrl: provider.frontFileId,
                    onTap: () {
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
                    onTap: () {
                      provider.pickImage(context, false);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            AppFormField(
              label: AppStrings.notesComments,
              controller: provider.notesController,
              readOnly: true,
              maxLines: 4,
            ),

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
                    text: AppStrings.saveCheque,
                    onPressed: provider.isSaving
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
