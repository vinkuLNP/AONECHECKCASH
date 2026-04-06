import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isDisabled;

  final bool isOutlined;
  final bool hasElevation;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color outlinedColor;

  final double height, width;
  final double borderRadius;
  final EdgeInsets padding;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.isOutlined = false,
    this.hasElevation = false,
    this.backgroundColor = AppColors.authThemeColor,
    this.borderColor = AppColors.authThemeColor,
    this.textColor = AppColors.whiteColor,
    this.outlinedColor = Colors.transparent,
    this.height = 50,
    this.borderRadius = 12,
    this.width = double.infinity,
    this.icon,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final isInteractive = !(isLoading || isDisabled);
    final Widget child = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              color: isOutlined ? borderColor : textColor,
              strokeWidth: 2.5,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              AppText(
                text: text,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          );
    return SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isInteractive ? onPressed : null,
              style: OutlinedButton.styleFrom(
                padding: padding,
                backgroundColor: outlinedColor,
                side: BorderSide(color: borderColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: isInteractive ? onPressed : null,
              style: ElevatedButton.styleFrom(
                elevation: hasElevation ? 2 : 0,
                padding: padding,
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: child,
            ),
    );
  }
}
