import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/service_item_entity.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final ServiceItem item;

  const ServiceCard({super.key, required this.item});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.item.onTap.call();
      },
      onTapCancel: () => setState(() => isPressed = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        transform: Matrix4.identity()..scale(isPressed ? 0.97 : 1.0),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: isPressed ? 6 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDECEC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.item.icon, color: AppColors.primary),
            ),

            const SizedBox(height: 12),

            AppText(
              text: widget.item.title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),

            const SizedBox(height: 6),

            AppText(
              text: widget.item.desc,
              textAlign: TextAlign.center,
              fontSize: 13,
              color: const Color(0xFF6B7280),
            ),

            const Spacer(),

            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  AppText(
                    text: AppStrings.learnMore,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC62828),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: Color(0xFFC62828),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
