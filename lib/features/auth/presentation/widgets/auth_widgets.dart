import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/app_text_style.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

Widget backToHomeButton(BuildContext context) => AppButton(
  width: 200,
  textColor: AppColors.primary,
  text: AppStrings.backToHomePage,
  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
  isOutlined: true,
  icon: Icon(Icons.arrow_back, color: AppColors.primary),
);

Widget termsAndPrivacy() => Padding(
  padding: const EdgeInsets.all(12),
  child: RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: appTextStyle(color: AppColors.textLight),
      children: [
        TextSpan(text: AppStrings.termsPrefix),
        TextSpan(
          text: AppStrings.terms,
          style: appTextStyle(color: Colors.red),
        ),
        TextSpan(text: " ${AppStrings.and} "),
        TextSpan(
          text: AppStrings.privacy,
          style: appTextStyle(color: Colors.red),
        ),
      ],
    ),
  ),
);

Widget authContainer({required Widget child}) => Container(
  constraints: const BoxConstraints(maxWidth: 400),
  margin: const EdgeInsets.symmetric(horizontal: 16),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: AppColors.lightWhite.withValues(alpha: 0.9),

    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(blurRadius: 10, color: Colors.black.withValues(alpha: 0.05)),
    ],
  ),
  child: child,
);
