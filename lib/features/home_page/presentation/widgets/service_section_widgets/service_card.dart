import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_enum.dart';
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

  void _onTapDown(_) => setState(() => isPressed = true);

  void _onTapUp(_) {
    setState(() => isPressed = false);
    widget.item.onTap.call();
  }

  void _onTapCancel() => setState(() => isPressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,

      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: isPressed ? 0.96 : 1.0,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: AppColors.whiteColor.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: isPressed ? 6 : 14,
                offset: Offset(0, isPressed ? 3 : 8),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isPressed
                      ? const Color.fromARGB(255, 235, 200, 200)
                      : const Color.fromARGB(255, 243, 215, 215),
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
                color: AppColors.textLight,
              ),

              const Spacer(),

              AppButton(
                text: AppStrings.learnMore,
                iconPosition: IconPosition.suffix,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                onPressed: widget.item.onTap,
                width: 140,
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
