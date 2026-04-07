import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/provider/upload_provider.dart';
import 'package:a1_check_cashers/features/upload_image/presentation/screens/upload_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploadProvider>();

    return Scaffold(
      backgroundColor: AppColors.heroColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.uploadView);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildHeader(provider, context),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.items.isEmpty
                ? _emptyView(context)
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, i) =>
                        _documentCard(provider.items[i], i, context),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(UploadProvider provider, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.authThemeColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: AppStrings.documents,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),

                AppText(
                  text: "${provider.items.length} ${AppStrings.uploaded}",
                  color: Colors.white70,
                ),
              ],
            ),

            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),

              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.uploadView);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            AppText(
              text: AppStrings.noDocuments,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 8),
            AppText(
              text: AppStrings.uploadHintDescription,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),

            const SizedBox(height: 24),
            AppButton(
              text: AppStrings.uploadDocument,
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.uploadView),
              width: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentCard(Item item, int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: item.imageUrl.isNotEmpty
                      ? Image.network(item.imageUrl, fit: BoxFit.cover)
                      : const Icon(Icons.image_not_supported),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: PopupMenuButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onSelected: (value) {
                    if (value == AppStrings.keyEdit) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UploadScreen(item: item),
                        ),
                      );
                    } else {
                      context.read<UploadProvider>().delete(index);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: AppStrings.keyEdit,
                      child: AppText(text: AppStrings.edit),
                    ),
                    PopupMenuItem(
                      value: AppStrings.keyDelete,
                      child: AppText(text: AppStrings.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColors.textLight.withValues(alpha: 0.1),

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: item.description,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(Icons.access_time, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      AppText(
                        text: AppStrings.uploadedRecently,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
