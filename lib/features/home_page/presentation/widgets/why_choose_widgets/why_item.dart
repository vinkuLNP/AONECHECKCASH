import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/why_choose_item.dart';
import 'package:flutter/material.dart';

class WhyItem extends StatefulWidget {
  final WhyChooseItem item;
  final bool lastItem;

  const WhyItem({super.key, required this.item, required this.lastItem});

  @override
  State<WhyItem> createState() => _WhyItemState();
}

class _WhyItemState extends State<WhyItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: EdgeInsets.only(bottom: widget.lastItem ? 0 : 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: isPressed ? 6 : 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Transform.scale(
          scale: isPressed ? 0.97 : 1.0,

          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightWhite,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  widget.item.icon,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: AppText(
                  text: widget.item.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
