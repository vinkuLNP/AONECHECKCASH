import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class PrepaidCard extends StatelessWidget {
  const PrepaidCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: AppStrings.prepaidPromoTitle,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),

        const SizedBox(height: 12),

        AppText(
          text: AppStrings.prepaidPromoDescription,
          fontSize: 15,
          color: Colors.white70,
        ),

        const SizedBox(height: 10),

        AppText(
          text: AppStrings.prepaidPromoSubText,
          fontSize: 13,
          color: Colors.white60,
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: AppButton(
                text: AppStrings.learnMore,
                backgroundColor: Colors.white,
                textColor: AppColors.primary,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                text: AppStrings.findStore,
                isOutlined: true,
                borderColor: Colors.white,
                textColor: Colors.white,
                outlinedColor: Colors.transparent,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
