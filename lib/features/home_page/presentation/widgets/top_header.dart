import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class TopHeader extends StatelessWidget {
  final bool showDrawer;
  const TopHeader({super.key, this.showDrawer = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.textDark,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: const [
              AppText(
                text: AppStrings.openToday,
                color: AppColors.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 2),
              AppText(
                text: AppStrings.nearestLocation,
                color: Colors.white70,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppText(
                    text: AppStrings.appName,
                    color: AppColors.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 2),
                  AppText(
                    text: AppStrings.subtitle,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ],
              ),
              if (showDrawer) ...[
                const Spacer(),
                AppButton(
                  width: 100,
                  text: AppStrings.signIn,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.login),
                  isOutlined: true,
                  icon: Icon(Icons.person, color: AppColors.primary),
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, size: 26),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
