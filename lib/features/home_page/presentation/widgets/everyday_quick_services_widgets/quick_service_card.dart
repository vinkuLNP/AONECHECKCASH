import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/quick_service_entity.dart';
import 'package:flutter/material.dart';

class QuickServiceCard extends StatelessWidget {
  final QuickServiceEntity item;

  const QuickServiceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEAEAEA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: AppColors.primary, size: 28),
          ),

          const SizedBox(height: 18),

          AppText(
            text: item.title,
            textAlign: TextAlign.center,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFC62828),
          ),

          const SizedBox(height: 10),

          AppText(
            text: item.description,
            textAlign: TextAlign.center,
            fontSize: 15,
            height: 1.55,
            color: const Color(0xFF4B5563),
          ),

          const SizedBox(height: 14),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                AppText(
                  text: AppStrings.learnMore,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFC62828),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Color(0xFFC62828),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}