import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/why_choose_item.dart';

class WhyChooseLocalData {
  static List<WhyChooseItem> getItems() {
    return [
      WhyChooseItem(
        title: AppStrings.fastService,
        icon: Icons.access_time,
      ),
      WhyChooseItem(
        title: AppStrings.nearbyLocations,
        icon: Icons.location_on,
      ),
      WhyChooseItem(
        title: AppStrings.multipleServices,
        icon: Icons.layers,
      ),
      WhyChooseItem(
        title: AppStrings.friendlyStaff,
        icon: Icons.people,
      ),
      WhyChooseItem(
        title: AppStrings.easyPayments,
        icon: Icons.credit_card,
      ),
      WhyChooseItem(
        title: AppStrings.bilingualSupport,
        icon: Icons.language,
      ),
    ];
  }
}