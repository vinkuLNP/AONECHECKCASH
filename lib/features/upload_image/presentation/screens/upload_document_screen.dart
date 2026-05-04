import 'dart:io';
import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
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
  File? frontImage;
  File? backImage;

  String? frontNetworkImage;
  String? backNetworkImage;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      controller.text = widget.item!.description;
      frontNetworkImage = widget.item!.frontImageUrl.isNotEmpty
          ? widget.item!.frontImageUrl
          : widget.item!.backImageUrl;
      backNetworkImage = widget.item!.backImageUrl.isNotEmpty
          ? widget.item!.backImageUrl
          : widget.item!.frontImageUrl;
    }
  }

  Future pickImage(ImageSource source, bool isFront) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        if (isFront) {
          frontImage = File(picked.path);
          frontNetworkImage = null;
        } else {
          backImage = File(picked.path);
          backNetworkImage = null;
        }
      });
    }
  }

  void showPicker(bool isFront) {
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
                pickImage(ImageSource.camera, isFront);
              },
            ),
            ListTile(
              title: AppText(
                text: AppStrings.gallery,
                color: AppColors.textDark,
              ),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery, isFront);
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
      frontImage: frontImage,
      backImage: backImage,
      existingFrontFileId: widget.item?.frontFileId,
      existingBackFileId: widget.item?.backFileId,
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
              onTap: () => showPicker(true),
              child: containerImageBuild(
                frontImage,
                frontNetworkImage,
                AppStrings.uploadFrontImage,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => showPicker(false),
              child: containerImageBuild(
                backImage,
                backNetworkImage,
                AppStrings.uploadBackImage,
              ),
            ),
            // const SizedBox(height: 20),
            // AppInputField(
            //   label: AppStrings.descriptionLabel,
            //   controller: controller,
            //   fillColor: Colors.white.withValues(alpha: 0.8),
            //   focusColor: Colors.white,
            //   borderColor: Colors.white,
            //   labelColor: AppColors.textLight,
            //   fillTextField: true,
            // ),
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

  Widget containerImageBuild(File? file, String? network, String label) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
        color: Colors.white.withValues(alpha: 0.8),
      ),
      child: _buildImageView(file, network, label),
    );
  }

  Widget _buildImageView(File? file, String? network, String label) {
    if (file != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(file, fit: BoxFit.cover),
      );
    }

    if (network != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(network, fit: BoxFit.cover),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.upload_file, size: 40, color: Colors.grey),
        SizedBox(height: 10),
        AppText(text: label),
      ],
    );
  }
}
