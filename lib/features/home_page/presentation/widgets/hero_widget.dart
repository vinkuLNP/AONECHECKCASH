import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final zipController = TextEditingController();
    return Container(
      color: const Color(0xFFF6F3F2),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.heroTitle,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: Color(0xFF111827),
          ),

          const SizedBox(height: 12),

          const AppText(
            text: AppStrings.heroSubtitle,
            fontSize: 15,
            height: 1.5,
            color: Color(0xFF6B7280),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                AppInputField(
                  label: "",
                  controller: zipController,
                  hint: AppStrings.enterZip,
                  isDense: true,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 14),

                AppButton(
                  text: AppStrings.findStore,
                  icon: const Icon(Icons.location_on, color: Colors.white),
                  onPressed: () {},
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.near_me, size: 18, color: Colors.red),
                      SizedBox(width: 6),
                      AppText(
                        text: AppStrings.useMyLocation,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          AppButton(
            text: AppStrings.getDirections,
            isOutlined: true,
            borderColor: Colors.red,
            textColor: Colors.red,
            outlinedColor: Color(0xFFF6F3F2),
            icon: const Icon(Icons.location_on, color: Colors.red),
          ),
          const SizedBox(height: 12),

          AppButton(
            text: AppStrings.callNow,
            isOutlined: true,
            outlinedColor: Color(0xFFF6F3F2),
            borderColor: Colors.red,
            icon: const Icon(Icons.phone, color: Colors.red),
          ),
          const SizedBox(height: 18),

          const Center(
            child: AppText(
              text: AppStrings.tagline,
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}
