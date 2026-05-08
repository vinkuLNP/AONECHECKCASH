import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_card.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_info_column.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/app_status_chip.dart';
import 'package:a1_check_cashers/features/cheque/presentation/widgets/cheque_notes_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/date_extension.dart';
import '../../domain/entities/cheque_entity.dart';
import '../../domain/enum/cheque_status_enum.dart';

class ChequeCard extends StatelessWidget {
  final Cheque cheque;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onView;

  const ChequeCard({
    super.key,
    required this.cheque,
    required this.onEdit,
    this.onDelete,
    this.onView,
  });

  bool get isReadOnly => cheque.status == ChequeStatus.needMoreInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.heroColor,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.red.withValues(alpha: .25)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _buildHeader(),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: AppInfoColumn(
                  title: AppStrings.type,
                  value: cheque.type.chequeTypeName,
                  titleColor: AppColors.secondaryText,
                  valueColor: AppColors.primaryText,
                ),
              ),

              Expanded(
                child: AppInfoColumn(
                  title: AppStrings.makerName,
                  value: cheque.makerName,
                  titleColor: AppColors.secondaryText,
                  valueColor: AppColors.primaryText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AppImagePickerCard(
                  height: 100,

                  title: AppStrings.frontSide,
                  imageUrl: cheque.frontImage,
                  titleColor: AppColors.primary,
                  readOnly: true,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppImagePickerCard(
                  height: 100,
                  title: AppStrings.backSide,
                  imageUrl: cheque.backImage,
                  titleColor: AppColors.primary,
                  readOnly: true,
                ),
              ),
            ],
          ),

          if (cheque.notes != null && cheque.notes!.isNotEmpty) ...[
            const SizedBox(height: 14),

            ChequeNotesCard(notes: cheque.notes!),
          ],

          const SizedBox(height: 14),

          _buildActions(),

          const SizedBox(height: 12),

          AppText(
            text:
                "${AppStrings.created}: "
                "${cheque.createdAt.toFormattedDate()}",
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(
          children: [
            AppText(
              text: "#${cheque.chequeNumber}",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(width: 10),

            AppStatusChip(
              title: cheque.status.status,
              icon: cheque.status.statusIcon,
              color: cheque.status.statusColor,
            ),
          ],
        ),

        Column(
          children: [
            AppText(
              text: "\$${cheque.amount.toStringAsFixed(2)}",
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

            const SizedBox(height: 2),

            AppText(
              text: cheque.chequeDate.toFormattedDate(),
              color: AppColors.secondaryText,
              fontSize: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: AppStrings.view,
            onPressed: onView,
            isOutlined: true,
            textColor: AppColors.primary,
            icon: const Icon(
              Icons.remove_red_eye,
              color: AppColors.primary,
              size: 18,
            ),
          ),
        ),

        if (isReadOnly) ...[
          const SizedBox(width: 10),

          Expanded(
            child: AppButton(
              text: AppStrings.edit,
              onPressed: onEdit,
              textColor: AppColors.whiteColor,
              icon: const Icon(
                Icons.edit,
                color: AppColors.whiteColor,
                size: 18,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
