import 'package:a1_check_cashers/core/constants/app_assets.dart';
import 'package:a1_check_cashers/features/home_page/data/data_sources/highlight_local_data.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_widgets/app_common_text_widget.dart';
import '../../../../core/app_widgets/app_common_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class HighlightSection extends StatelessWidget {
  const HighlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    final points = HighlightLocalData.getPoints();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              cashCheckImage,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFDECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const AppText(
              text: AppStrings.popularService,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          const AppText(
            text: AppStrings.highlightTitle,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),

          const SizedBox(height: 10),

          const AppText(
            text: AppStrings.highlightDesc,
            fontSize: 15,
            height: 1.6,
            color: Color(0xFF6B7280),
          ),

          const SizedBox(height: 16),
          Column(
            children: points.map((text) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDECEC),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: AppText(
                        text: text,
                        fontSize: 15,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          AppButton(text: AppStrings.cashCheck, onPressed: () {}),

          const SizedBox(height: 12),

          AppButton(
            text: AppStrings.findStore,
            isOutlined: true,
            borderColor: AppColors.primary,
            outlinedColor: Colors.white,
            icon: const Icon(Icons.location_on, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
