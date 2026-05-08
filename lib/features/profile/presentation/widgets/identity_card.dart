import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_card.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class IdentityCard extends StatelessWidget {
  final ProfileProvider profileProvider;
  const IdentityCard(this.profileProvider, {super.key});

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
            options: RoundedRectDottedBorderOptions(
              dashPattern: const [6, 4],
              color: Colors.grey.shade500,
              radius: Radius.circular(12),
              padding: const EdgeInsets.all(2),
            ),
            child: AppImagePickerCard(
              height: 160,
              imageUrl: profileProvider.user?.idFrontImage,
              isLoading: profileProvider.isUploadingId,
              onImageSelected: (file) async {
                await profileProvider.uploadFrontId(file);
              },
              title: AppStrings.uploadIdDocument,
              subtitle: AppStrings.uploadIdHint,
              showTitle: false,
            ),
          ),
        ],
      ),
    );
  }
}
