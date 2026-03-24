import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class BusinessHeader extends StatelessWidget {
  const BusinessHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: const [
          AppText(
            text: AppStrings.businessSectionTitle,
            textAlign: TextAlign.center,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
          SizedBox(height: 12),
          AppText(
            text: AppStrings.businessSectionSubtitle,
            textAlign: TextAlign.center,
            fontSize: 16,
            height: 1.6,
            color: Color(0xFF6B7280),
          ),
        ],
      ),
    );
  }
}