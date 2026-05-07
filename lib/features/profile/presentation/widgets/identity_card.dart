import 'dart:io';

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IdentityCard extends StatelessWidget {
  final ProfileProvider p;
  const IdentityCard(this.p, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.identityVerification,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
          const SizedBox(height: 16),

          DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: const [6, 4],
              color: Colors.grey.shade500,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (picked != null) {
                  p.uploadFrontId(File(picked.path));
                }
              },
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(color: const Color(0xFFF9F9F9)),
                child: p.user?.idFrontImage != null
                    ? Image.network(p.user!.idFrontImage!, fit: BoxFit.cover)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 30,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 10),
                          const AppText(
                            text: AppStrings.uploadIdDocument,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            text: AppStrings.uploadIdHint,
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
