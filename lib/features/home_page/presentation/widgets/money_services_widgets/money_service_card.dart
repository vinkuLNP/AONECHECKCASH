import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/money_service_entity.dart';
import 'package:flutter/material.dart';

class MoneyServiceCard extends StatelessWidget {
  final MoneyServiceItem item;

  const MoneyServiceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = item.isDark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF08172F).withValues(alpha: 0.6)
            : const Color(0xFFF8F4F4),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              item.icon,
              color: isDark ? Colors.white : AppColors.primary,
              size: 32,
            ),
          ),

          const SizedBox(height: 20),

          AppText(
            text: item.title,
            textAlign: TextAlign.center,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: isDark ? Colors.white :  AppColors.textDark,
          ),

          const SizedBox(height: 20),

          AppText(
            text: item.description,
            textAlign: TextAlign.center,
            fontSize: 16,
            color: isDark
                ? Colors.white.withValues(alpha: 0.85)
                : const Color(0xFF4B5563),
          ),

          const Spacer(),

          AppButton(
            text: item.buttonText,
            backgroundColor: isDark ? Colors.white : AppColors.primary,
            textColor: isDark ? const Color(0xFF08172F) : Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
