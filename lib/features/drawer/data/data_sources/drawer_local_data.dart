import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/drawer/domain/entities/drawer_entity.dart';

class DrawerLocalDataSource {
  List<DrawerItem> getDrawerItems() {
    return [
      DrawerItem(title: AppStrings.home),
      DrawerItem(title: AppStrings.checkCashing),
      DrawerItem(title: AppStrings.moneyTransfer),
      DrawerItem(title: AppStrings.moneyOrders),
      DrawerItem(title: AppStrings.billPay),
      DrawerItem(title: AppStrings.prepaidCards),
      DrawerItem(title: AppStrings.convenienceServices),
      DrawerItem(title: AppStrings.auto),
      DrawerItem(title: AppStrings.locations),
      DrawerItem(title: AppStrings.careers),
      DrawerItem(title: AppStrings.contact),
    ];
  }
}
