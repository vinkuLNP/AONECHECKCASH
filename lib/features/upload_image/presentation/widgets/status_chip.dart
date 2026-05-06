import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget statusChip({required String status}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: AppColors.primary.withValues(alpha: .35)),
  ),
  child: AppText(text: status, color: AppColors.textLight, fontSize: 14),
);
