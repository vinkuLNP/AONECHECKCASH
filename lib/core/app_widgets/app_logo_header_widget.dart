import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_assets.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppLogoHeaderWidget extends StatelessWidget {
  final bool textColor;
  const AppLogoHeaderWidget({super.key, this.textColor = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(appLogo, height: 60, width: 60),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: AppStrings.subtitle.toUpperCase(),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: textColor ? AppColors.whiteColor : AppColors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 26,
                  width: 26,
                  child: Image.asset(westernUnionLogo, height: 26, width: 26),
                ),
                Column(
                  children: [
                    AppText(
                      text: AppStrings.westernUnion,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor ? AppColors.whiteColor : AppColors.black,
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
