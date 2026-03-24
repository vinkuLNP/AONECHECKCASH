import 'package:a1_check_cashers/features/home_page/domain/entities/money_service_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class MoneyServicesLocalData {
  static List<MoneyServiceItem> getItems() {
    return const [
      MoneyServiceItem(
        title: AppStrings.moneyTransferTitle,
        description: AppStrings.moneyTransferDescLong,
        buttonText: AppStrings.learnMoneyTransfer,
        icon: Icons.near_me_rounded,
        isDark: false,
      ),
      MoneyServiceItem(
        title: AppStrings.moneyOrderTitle,
        description: AppStrings.moneyOrderDescLong,
        buttonText: AppStrings.learnMoneyOrders,
        icon: Icons.shield_outlined,
        isDark: true,
      ),
    ];
  }
}