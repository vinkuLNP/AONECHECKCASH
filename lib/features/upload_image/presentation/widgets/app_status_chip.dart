import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:flutter/material.dart';

class AppStatusChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const AppStatusChip({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),

          const SizedBox(width: 4),

          AppText(text: title, color: Colors.white, fontSize: 12),
        ],
      ),
    );
  }
}
