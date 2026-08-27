import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/core/utils/file_utils.dart';
import 'package:a1_check_cashers/features/home_page/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    final zipController = TextEditingController();
    return Container(
      color: AppColors.heroColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.heroTitle,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: AppColors.primary,
          ),

          const SizedBox(height: 20),

          const AppText(
            text: AppStrings.heroSubtitle,
            fontSize: 15,
            height: 1.5,
            color: AppColors.textLight,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppInputField(
                  label: "",
                  fillColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  borderColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  focusColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  controller: zipController,
                  hint: AppStrings.enterZip,
                  isDense: true,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Flexible(
                flex: 1,
                child: AppButton(
                  text: AppStrings.findStore,
                  onPressed: () async {
                    controller.searchStoreByZip(
                      context,
                      zipController.text.trim(),
                    );
                  },
                  isOutlined: true,
                  borderColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          GestureDetector(
            onTap: () async {
              controller.useCurrentLocation(context);
            },
            child: const Row(
              children: [
                Icon(
                  Icons.near_me_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(width: 6),
                AppText(
                  text: AppStrings.useMyLocation,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  fontSize: 13,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () => openUrl(AppStrings.storeLocationsUrl),
                  text: AppStrings.getDirections,
                  isOutlined: true,
                  borderColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  text: AppStrings.verifyCheckNow,
                  isOutlined: true,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  icon: const Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                  onPressed: () async {
                    final isLoggedIn = await SessionManager.isLoggedIn();
                    if (isLoggedIn) {
                      Navigator.pushNamed(context, AppRoutes.profileView);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.login);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: AppText(
              text: AppStrings.tagline,
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
