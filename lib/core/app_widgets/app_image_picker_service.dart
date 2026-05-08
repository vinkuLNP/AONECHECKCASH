import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static const int maxFileSizeInBytes = 2 * 1024 * 1024;

  static Future<File?> pickImage(
    BuildContext context, {
    bool compress = true,
    int quality = 60,
    bool allowCamera = true,
    bool allowGallery = true,
  }) async {
    ImageSource? source;

    if (allowCamera && allowGallery) {
      source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.white,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: AppText(text: AppStrings.camera),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: AppText(text: AppStrings.gallery),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (allowCamera) {
      source = ImageSource.camera;
    } else {
      source = ImageSource.gallery;
    }

    if (source == null) return null;

    final picked = await _picker.pickImage(source: source);

    if (picked == null) return null;

    File file = File(picked.path);

    if (compress) {
      file = await _compressImage(file, quality);
    }

    final fileSize = await file.length();

    if (fileSize > maxFileSizeInBytes) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AppText(
              text: AppStrings.imageSizeShouldNotExceed,
              color: AppColors.whiteColor,
            ),
          ),
        );
      }

      return null;
    }

    return file;
  }

  static Future<File> _compressImage(File file, int quality) async {
    File currentFile = file;
    int currentQuality = quality;

    while (true) {
      final targetPath =
          '${file.parent.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final compressed = await FlutterImageCompress.compressAndGetFile(
        currentFile.absolute.path,
        targetPath,
        quality: currentQuality,
      );

      if (compressed == null) {
        return currentFile;
      }

      final compressedFile = File(compressed.path);

      final size = await compressedFile.length();

      if (size <= maxFileSizeInBytes || currentQuality <= 20) {
        return compressedFile;
      }

      currentQuality -= 10;
      currentFile = compressedFile;
    }
  }
}
