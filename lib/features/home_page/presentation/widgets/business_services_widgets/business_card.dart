import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/business_service_entity.dart';
import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  final BusinessServiceEntity item;

  const BusinessCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: AppColors.primary, size: 26),
          ),

          const SizedBox(height: 18),

          AppText(
            text: item.title,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: AppText(
              text: item.description,
              fontSize: 15,
              height: 1.5,
              color: const Color(0xFF4B5563),
            ),
          ),

          const SizedBox(height: 14),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: item.buttonText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC62828),
                ),
                const SizedBox(width: 6),
                const Icon(
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
