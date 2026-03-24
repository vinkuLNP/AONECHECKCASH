import 'package:a1_check_cashers/features/home_page/domain/entities/support_item_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class CustomerSupportLocalData {
  static List<SupportItem> getItems() {
    return const [
      SupportItem(title: AppStrings.findStore, icon: Icons.storefront_outlined),
      SupportItem(title: AppStrings.callNow, icon: Icons.call_outlined),
      SupportItem(
        title: AppStrings.contactUs,
        icon: Icons.mail_outline_rounded,
      ),
    ];
  }
}
