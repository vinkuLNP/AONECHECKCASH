import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  static final ImagePicker _picker = ImagePicker();

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

    final picked = await _picker.pickImage(
      source: source,
      imageQuality: quality,
    );

    if (picked == null) return null;

    File file = File(picked.path);

    if (!compress) return file;

    return await _compressImage(file, quality);
  }

  static Future<File> _compressImage(File file, int quality) async {
    final targetPath =
        '${file.parent.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
    );

    return File(compressed!.path);
  }
}
