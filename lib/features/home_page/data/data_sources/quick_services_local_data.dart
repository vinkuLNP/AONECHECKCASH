import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/quick_service_entity.dart';

class QuickServicesLocalData {
  List<QuickServiceEntity> getServices() {
    return const [
      QuickServiceEntity(
        title: AppStrings.billPay,
        description: AppStrings.billPayQuickDesc,
        icon: Icons.receipt_long_outlined,
      ),
      QuickServiceEntity(
        title: AppStrings.prepaidCards,
        description: AppStrings.prepaidCardsQuickDesc,
        icon: Icons.credit_card_outlined,
      ),
      QuickServiceEntity(
        title: AppStrings.convenienceServices,
        description: AppStrings.convenienceServicesQuickDesc,
        icon: Icons.miscellaneous_services_outlined,
      ),
    ];
  }
}
