import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_network_image.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ChequeImageBox extends StatelessWidget {
  final String title;
  final String? image;
  const ChequeImageBox({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            color: AppColors.primary.withValues(alpha: .8),
            fontSize: 13,
          ),
          const SizedBox(height: 8),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: AppImageBox(
              imageUrl: image,
              height: 80,
              showBorder: true,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
