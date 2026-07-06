import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_logo_header_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';

class TopHeader extends StatelessWidget {
  final bool showDrawer;
  const TopHeader({super.key, this.showDrawer = true});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.primary,
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
                color: AppColors.whiteColor,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.darkRed,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!showDrawer) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
                child: const AppLogoHeaderWidget(textColor: true),
              ),
              if (showDrawer) ...[
                const Spacer(),
                AppButton(
                  width: 100,

                  text: auth.isLoggedIn
                      ? auth.loginUser?.name ?? AppStrings.profile
                      : AppStrings.signIn,
                  onPressed: () async {
                    if (auth.isLoggedIn) {
                      Navigator.pushNamed(context, AppRoutes.profileView);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.login);
                    }
                  },

                  isOutlined: true,
                  outlinedColor: AppColors.darkRed,
                  borderColor: AppColors.whiteColor,
                  icon: auth.isLoggedIn
                      ? null
                      : Icon(Icons.person, color: AppColors.whiteColor),
                ),
                /*  Drawer Button 
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 26,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),*/
              ],
            ],
          ),
        ),
      ],
    );
  }
}
