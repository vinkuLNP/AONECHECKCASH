import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/support_item_entity.dart';
import 'package:flutter/material.dart';

class SupportCard extends StatelessWidget {
  final SupportItem item;

  const SupportCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 22),
            ),

            const SizedBox(height: 10),

            AppText(
              text: item.title,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
