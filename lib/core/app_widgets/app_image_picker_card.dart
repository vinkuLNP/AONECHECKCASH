import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_image_picker_service.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/profile/presentation/widgets/pdf_viewer_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum PickerFileType { image, pdf }

class AppImagePickerCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? errorText;

  final File? file;

  final String? imageUrl;

  final String? fileUrl;

  final String? fileName;

  final bool isLoading;

  final Future<void> Function(File file)? onImageSelected;

  final double height;

  final BorderRadius borderRadius;

  final bool allowCamera;

  final bool showTitle;

  final bool allowGallery;

  final bool compressImage;

  final Widget? emptyWidget;

  final Widget? loadingWidget;

  final BoxFit fit;

  final bool readOnly;

  final Color titleColor;

  final PickerFileType fileType;

  const AppImagePickerCard({
    super.key,
    this.title,
    this.subtitle,
    this.errorText,
    this.file,
    this.imageUrl,
    this.fileUrl,
    this.fileName,
    this.isLoading = false,
    this.onImageSelected,
    this.height = 180,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.allowCamera = true,
    this.allowGallery = true,
    this.compressImage = true,
    this.showTitle = true,
    this.emptyWidget,
    this.loadingWidget,
    this.fit = BoxFit.cover,
    this.readOnly = false,
    this.titleColor = const Color.fromRGBO(97, 97, 97, 1),
    this.fileType = PickerFileType.image,
  });

  bool get isPdf => fileType == PickerFileType.pdf;

  bool get hasFile {
    if (isPdf) {
      return file != null || (fileUrl != null && fileUrl!.isNotEmpty);
    }

    return file != null || (imageUrl != null && imageUrl!.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppText(text: title!, fontSize: 13, color: titleColor),
          ),
        ],

        InkWell(
          borderRadius: borderRadius,
          onTap: isLoading
              ? null
              : () async {
                  if (!hasFile) {
                    if (readOnly) return;

                    final pickedFile = isPdf
                        ? await AppImagePickerService.pickPdf(context)
                        : await AppImagePickerService.pickImage(
                            context,
                            compress: compressImage,
                            allowCamera: allowCamera,
                            allowGallery: allowGallery,
                          );

                    if (pickedFile != null && onImageSelected != null) {
                      await onImageSelected!(pickedFile);
                    }

                    return;
                  }

                  await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (_) {
                      return SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(
                                isPdf
                                    ? Icons.picture_as_pdf
                                    : Icons.visibility_outlined,
                              ),
                              title: AppText(
                                text: isPdf
                                    ? AppStrings.viewPdf
                                    : AppStrings.viewImage,
                              ),
                              onTap: () {
                                Navigator.pop(context);

                                _openPreview(context);
                              },
                            ),

                            if (!readOnly)
                              ListTile(
                                leading: const Icon(Icons.edit_outlined),
                                title: AppText(
                                  text: isPdf
                                      ? AppStrings.replacePdf
                                      : AppStrings.replaceImage,
                                ),
                                onTap: () async {
                                  Navigator.pop(context);

                                  final pickedFile = isPdf
                                      ? await AppImagePickerService.pickPdf(
                                          context,
                                        )
                                      : await AppImagePickerService.pickImage(
                                          context,
                                          compress: compressImage,
                                          allowCamera: allowCamera,
                                          allowGallery: allowGallery,
                                        );

                                  if (pickedFile != null &&
                                      onImageSelected != null) {
                                    await onImageSelected!(pickedFile);
                                  }
                                },
                              ),

                            ListTile(
                              leading: const Icon(Icons.close),
                              title: const AppText(text: AppStrings.cancel),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
          child: Stack(
            children: [
              Container(
                height: height,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: hasFile ? _buildFileView() : _buildPlaceholder(),
              ),

              if (isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      borderRadius: borderRadius,
                    ),
                    child:
                        loadingWidget ??
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                  ),
                ),
            ],
          ),
        ),

        if (errorText != null) ...[
          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AppText(text: errorText!, fontSize: 12, color: Colors.red),
          ),
        ],
      ],
    );
  }

  Widget _buildFileView() {
    if (isPdf) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),

            const SizedBox(height: 8),

            AppText(
              text:
                  fileName ??
                  file?.path.split('/').last ??
                  AppStrings.uploadedFile,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 8),

            AppText(
              text: AppStrings.tapToViewOrReplace,
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      );
    }

    if (file != null) {
      return Image.file(file!, fit: fit, width: double.infinity);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: fit,
      width: double.infinity,
      placeholder: (_, __) {
        return Container(
          color: Colors.grey.shade200,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      },
      errorWidget: (_, __, ___) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              color: Colors.grey.shade500,
              size: 32,
            ),

            const SizedBox(height: 8),

            AppText(text: AppStrings.failedToLoadImage),
          ],
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    if (emptyWidget != null) {
      return emptyWidget!;
    }

    return Container(
      color: Colors.grey.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isPdf ? Icons.picture_as_pdf : Icons.cloud_upload_outlined,
            size: 34,
            color: Colors.grey.shade600,
          ),

          const SizedBox(height: 12),

          AppText(
            text:
                title ??
                (isPdf ? AppStrings.uploadPdf : AppStrings.uploadIdDocument),
            fontWeight: FontWeight.w600,
          ),

          const SizedBox(height: 4),

          AppText(
            text:
                subtitle ??
                (isPdf ? AppStrings.uploadPdf : AppStrings.uploadHint),
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  void _openPreview(BuildContext context) {
    if (isPdf) {
      final pdfPath = file?.path;

      if (pdfPath != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BusinessPdfViewerScreen(
              pdfPath: pdfPath,
              pdfUrl: fileUrl,
              title:
                  fileName ??
                  file?.path.split('/').last ??
                  AppStrings.pdfPreview,
              isLocal: true,
            ),
          ),
        );

        return;
      }

      if (fileUrl != null && fileUrl!.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BusinessPdfViewerScreen(
              pdfUrl: fileUrl,
              title: fileName ?? AppStrings.pdfPreview,
              isLocal: false,
            ),
          ),
        );
      }

      return;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4,
                child: Center(
                  child: file != null
                      ? Image.file(file!, fit: BoxFit.contain)
                      : CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),

              Positioned(
                top: 40,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
