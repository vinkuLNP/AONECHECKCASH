import 'dart:io';

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppImageBox extends StatelessWidget {
  final String? title;
  final File? file;
  final String? imageUrl;
  final VoidCallback? onTap;
  final double height;
  final BorderRadius borderRadius;
  final bool showBorder;

  const AppImageBox({
    super.key,
    this.title,
    this.file,
    this.imageUrl,
    this.onTap,
    this.height = 180,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = file != null || (imageUrl != null && imageUrl!.isNotEmpty);

    return Column(
      children: [
        if (title != null) ...[
          AppText(
            text: title!,
            color: AppColors.primary.withValues(alpha: .8),
            fontSize: 13,
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius,
              border: showBorder
                  ? Border.all(color: AppColors.primary.withValues(alpha: .25))
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: hasImage ? _buildImage() : _buildPlaceholder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (file != null) {
      return Image.file(file!, fit: BoxFit.cover, width: double.infinity);
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) {
        return const Center(child: Icon(Icons.image));
      },
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.upload_rounded, color: AppColors.primary, size: 40),
        if (title != null) ...[
          const SizedBox(height: 12),
          AppText(
            text: title!,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ],
      ],
    );
  }
}
