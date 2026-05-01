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
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(appLogo, height: 50, width: 50),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: AppStrings.subtitle.toUpperCase(),
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: textColor ? AppColors.whiteColor : AppColors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(westernUnionLogo, height: 30, width: 30),
                ),
                Column(
                  children: [
                    AppText(
                      text: AppStrings.westernUnion,
                      fontSize: 14,
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
