import 'package:a1_check_cashers/core/utils/file_utils.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/service_item_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class ServicesLocalData {
  static List<ServiceItem> getServices() {
    return [
      ServiceItem(
        title: AppStrings.checkCashing,
        desc: AppStrings.checkCashingDesc,
        icon: Icons.attach_money,
        onTap: () => openUrl(AppStrings.checkCashingUrl),
      ),
      ServiceItem(
        title: AppStrings.moneyTransfer,
        desc: AppStrings.moneyTransferDesc,
        icon: Icons.swap_horiz,
        onTap: () => openUrl(AppStrings.moneyTransferUrl),
      ),
      ServiceItem(
        title: AppStrings.moneyOrders,
        desc: AppStrings.moneyOrdersDesc,
        icon: Icons.receipt_long,
        onTap: () => openUrl(AppStrings.moneyOrdersUrl),
      ),
      ServiceItem(
        title: AppStrings.billPay,
        desc: AppStrings.billPayDesc,
        icon: Icons.payments,
        onTap: () => openUrl(AppStrings.billPayUrl),
      ),
      ServiceItem(
        title: AppStrings.businessCheckCashing,
        desc: AppStrings.businessCheckCashingDesc,
        icon: Icons.business_center,
        onTap: () => openUrl(AppStrings.businessCheckCashingUrl),
      ),
      ServiceItem(
        title: AppStrings.prepaidCards,
        desc: AppStrings.prepaidCardsDesc,
        icon: Icons.credit_card,
        onTap: () => openUrl(AppStrings.prepaidCardsUrl),
      ),
      ServiceItem(
        title: AppStrings.convenienceServices,
        desc: AppStrings.convenienceServicesDesc,
        icon: Icons.storefront,
        onTap: () => openUrl(AppStrings.convenienceServicesUrl),
      ),
      ServiceItem(
        title: AppStrings.a1Auto,
        desc: AppStrings.a1AutoDesc,
        icon: Icons.directions_car,
        onTap: () => openUrl(AppStrings.a1AutoUrl),
      ),
    ];
  }
}
