import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';

class CareersStripSection extends StatelessWidget {
  const CareersStripSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF111827),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppStrings.joinA1Team,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          AppText(
            text: AppStrings.careerDescription,
            fontSize: 15,
            color: const Color(0xFFCBD5E1),
          ),

          const SizedBox(height: 18),

          AppButton(text: AppStrings.viewCareer, onPressed: () {}),

          const SizedBox(height: 10),

          AppButton(
            text: AppStrings.applyNow,
            isOutlined: true,
            borderColor: Colors.white24,
            textColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
