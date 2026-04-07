import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  final Item? item;

  const UploadScreen({super.key, this.item});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? image;
  String? networkImage;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      controller.text = widget.item!.description;
      networkImage = widget.item!.imageUrl;
    }
  }

  Future pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
        networkImage = null;
      });
    }
  }

  void showPicker() {
    showModalBottomSheet(
      context: context,

      builder: (_) => Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: AppText(
                text: AppStrings.camera,
                color: AppColors.textDark,
              ),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              title: AppText(
                text: AppStrings.gallery,
                color: AppColors.textDark,
              ),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void save() async {
    final provider = context.read<UploadProvider>();
    final success = await provider.saveDocument(
      id: widget.item?.id,
      description: controller.text,
      image: image,
      existingImage: widget.item?.imageUrl,
    );
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploadProvider>();

    return Scaffold(
      backgroundColor: AppColors.heroColor,
      appBar: AppBar(
        title: AppText(
          text: widget.item != null
              ? AppStrings.editDocument
              : AppStrings.uploadDocument,
          color: Colors.white,
        ),
        backgroundColor: AppColors.authThemeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: showPicker,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                child: _buildImageView(),
              ),
            ),
            const SizedBox(height: 20),
            AppInputField(
              label: AppStrings.descriptionLabel,
              controller: controller,
              fillColor: Colors.white.withValues(alpha: 0.8),
              focusColor: Colors.white,
              borderColor: Colors.white,
              labelColor: AppColors.textLight,
              fillTextField: true,
            ),
            const SizedBox(height: 20),
            AppButton(
              isLoading: provider.isLoading,
              text: widget.item != null ? AppStrings.update : AppStrings.submit,
              onPressed: save,
              width: 200,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView() {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(image!, fit: BoxFit.cover),
      );
    }

    if (networkImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(networkImage!, fit: BoxFit.cover),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.upload_file, size: 40, color: Colors.grey),
        SizedBox(height: 10),
        AppText(text: AppStrings.uploadHint),
      ],
    );
  }
}
