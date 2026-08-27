import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/business_service_entity.dart';

class BusinessServicesLocalData {
  List<BusinessServiceEntity> getServices() {
    return const [
      BusinessServiceEntity(
        title: AppStrings.businessCheckCashing,
        description: AppStrings.businessCheckCashingBuisnessDesc,
        buttonText: AppStrings.learnMore,
        icon: Icons.business_center_outlined,
      ),
      BusinessServiceEntity(
        title: AppStrings.paymentServices,
        description: AppStrings.paymentServicesDesc,
        buttonText: AppStrings.learnMore,
        icon: Icons.payments_outlined,
      ),
      BusinessServiceEntity(
        title: AppStrings.storeSupport,
        description: AppStrings.storeSupportDesc,
        buttonText: AppStrings.findStore,
        icon: Icons.storefront_outlined,
      ),
    ];
  }
}
