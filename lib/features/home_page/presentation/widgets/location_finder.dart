import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';

class LocationFinderSection extends StatelessWidget {
  const LocationFinderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final zipController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppStrings.locationFinderTitle,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),

          const SizedBox(height: 14),

          AppText(
            text: AppStrings.locationFinderDescription,
            fontSize: 16,
            color: const Color(0xFFCBD5E1),
          ),

          const SizedBox(height: 22),

          AppInputField(
            label: "",
            controller: zipController,
            hint: AppStrings.enterZip,
            isDense: true,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: AppButton(text: AppStrings.findStore, onPressed: () {}),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: AppStrings.useMyLocation,
                  isOutlined: true,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  icon: const Icon(
                    Icons.my_location_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          AppText(
            text: AppStrings.locationFinderFooter,
            fontSize: 13,
            color: const Color(0xFF94A3B8),
          ),
        ],
      ),
    );
  }
}
