import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_card.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_service.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/business_check_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/pdf_viewer_screen.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class BusinessCheckCard extends StatelessWidget {
  final BusinessCheckProvider provider;

  const BusinessCheckCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final form = provider.form;

    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: const AppText(
                  text: AppStrings.businessCheckCashing,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Expanded(
                child: AppButton(
                  text: AppStrings.downloadForm,
                  onPressed: provider.downloadEmptyForm,
                  icon: const Icon(Icons.save_alt, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          AppImagePickerCard(
            height: 150,
            fileType: PickerFileType.pdf,
            fileUrl: provider.form?.fileUrl,
            fileName: provider.form?.fileName,
            isLoading: provider.isUploading,
            title: AppStrings.uploadFilledForm,
            subtitle: AppStrings.uploadFilledFormSubtitle,
            onImageSelected: (file) async {
              await provider.uploadBusinessForm(file);
            },
          ),

          if (form != null) ...[
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "${AppStrings.uploadedFile}: ${form.fileName}"),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: AppStrings.viewPdf,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BusinessPdfViewerScreen(
                                  pdfUrl: form.fileUrl!,
                                  title: form.fileName ?? '',
                                  isLocal: false,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          text: AppStrings.reUpload,
                          onPressed: () async {
                            final file = await AppImagePickerService.pickPdf(
                              context,
                            );

                            if (file != null) {
                              await provider.uploadBusinessForm(file);
                            }
                          },
                          icon: const Icon(
                            Icons.upload,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
