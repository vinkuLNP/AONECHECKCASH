import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/app_logo_header_widget.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../provider/drawer_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DrawerProvider>();

    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLogoHeaderWidget(),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(color: AppColors.textLight.withValues(alpha: 0.5)),

            Expanded(
              child: ListView.builder(
                itemCount: provider.items.length,
                itemBuilder: (context, index) {
                  final item = provider.items[index];
                  final isSelected = item == provider.selectedItem;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        provider.selectItem(item);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: AppText(
                                text: item.title,

                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              trailing: item.hasChildren
                                  ? Icon(
                                      provider.isExpanded(item)
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.black54,
                                    )
                                  : null,
                              onTap: () {
                                if (item.hasChildren) {
                                  provider.toggleExpand(item);
                                } else {
                                  provider.selectItem(item);
                                }
                              },
                            ),
                            if (item.hasChildren && provider.isExpanded(item))
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  children: item.subItems!.map((subItem) {
                                    final isSubSelected =
                                        subItem == provider.selectedItem;

                                    return ListTile(
                                      title: AppText(
                                        text: subItem.title,
                                        fontSize: 14,
                                        color: isSubSelected
                                            ? AppColors.primary
                                            : Colors.black54,
                                      ),
                                      onTap: () {
                                        provider.selectItem(subItem);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppButton(
                    text: AppStrings.findStore,
                    onPressed: () {},
                    icon: Icon(Icons.location_on, color: AppColors.whiteColor),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: AppStrings.verifyCheckNow,
                    onPressed: () async {
                      final isLoggedIn = await SessionManager.isLoggedIn();
                      if (isLoggedIn) {
                        Navigator.pushNamed(context, AppRoutes.profileView);
                      } else {
                        Navigator.pushNamed(context, AppRoutes.login);
                      }
                    },
                    isOutlined: true,
                    textColor: AppColors.primary,
                    icon: Icon(Icons.check, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  AppText(text: AppStrings.language),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
