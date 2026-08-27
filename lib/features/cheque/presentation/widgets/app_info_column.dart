import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:flutter/material.dart';

class AppInfoColumn extends StatelessWidget {
  final String title;
  final String value;
  final Color titleColor;
  final Color valueColor;

  const AppInfoColumn({
    super.key,
    required this.title,
    required this.value,
    required this.titleColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: title, color: titleColor, fontSize: 12),

        const SizedBox(height: 4),

        AppText(text: value, color: valueColor, fontSize: 14),
      ],
    );
  }
}
