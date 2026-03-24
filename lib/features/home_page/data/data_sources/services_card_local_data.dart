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
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.moneyTransfer,
        desc: AppStrings.moneyTransferDesc,
        icon: Icons.swap_horiz,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.moneyOrders,
        desc: AppStrings.moneyOrdersDesc,
        icon: Icons.receipt_long,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.billPay,
        desc: AppStrings.billPayDesc,
        icon: Icons.payments,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.businessCheckCashing,
        desc: AppStrings.businessCheckCashingDesc,
        icon: Icons.business_center,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.prepaidCards,
        desc: AppStrings.prepaidCardsDesc,
        icon: Icons.credit_card,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.convenienceServices,
        desc: AppStrings.convenienceServicesDesc,
        icon: Icons.storefront,
        onTap: () => {},
      ),
      ServiceItem(
        title: AppStrings.a1Auto,
        desc: AppStrings.a1AutoDesc,
        icon: Icons.directions_car,
        onTap: () => {},
      ),
    ];
  }
}
