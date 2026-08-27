import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/features/drawer/domain/entities/drawer_entity.dart';

class DrawerLocalDataSource {
  List<DrawerItem> getDrawerItems() {
    return [
      DrawerItem(title: AppStrings.home),

      DrawerItem(
        title: AppStrings.money,
        subItems: [
          DrawerItem(title: AppStrings.checkCashing),
          DrawerItem(title: AppStrings.businessCheckCashing),
          DrawerItem(title: AppStrings.moneyTransfer),
          DrawerItem(title: AppStrings.moneyOrders),
          DrawerItem(title: AppStrings.billPayments),
          DrawerItem(title: AppStrings.cash4Debit),
        ],
      ),
      DrawerItem(
        title: AppStrings.prepaidCards,
        subItems: [
          DrawerItem(title: AppStrings.nexsCard),
          DrawerItem(title: AppStrings.wuCard),
        ],
      ),

      DrawerItem(
        title: AppStrings.convenienceServices,
        subItems: [
          DrawerItem(title: AppStrings.faxCopies),
          DrawerItem(title: AppStrings.notary),
          DrawerItem(title: AppStrings.postage),
        ],
      ),
      DrawerItem(title: AppStrings.auto),
      DrawerItem(title: AppStrings.locations),
      DrawerItem(title: AppStrings.careers),
    ];
  }
}
