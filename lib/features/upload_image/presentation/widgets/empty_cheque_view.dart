import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/screens/cheque/cheque_screen_main.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class EmptyChequeView extends StatelessWidget {
  const EmptyChequeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      alignment: Alignment.bottomCenter,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 16),

            const AppText(
              text: AppStrings.noChequesFound,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 6),

            AppText(
              text: AppStrings.emptyChequeMessage,
              fontSize: 13,
              color: Colors.grey.shade600,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            AppButton(
              borderRadius: 4,
              width: MediaQuery.of(context).size.width / 2,
              text: AppStrings.addCheque,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditChequeScreen()),
                );
              },
              icon: Icon(Icons.add, color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
