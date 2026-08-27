import 'package:a1_check_cashers/core/constants/app_strings.dart';

enum ChequeType {
  personal,
  business,
  cashiers,
  certified,
  bankersDraft,
  travelers,
  eCheck,
  other,
}

extension ChequeTypeExtension on ChequeType {
  String get chequeTypeName {
    switch (this) {
      case ChequeType.personal:
        return AppStrings.personalCheck;
      case ChequeType.business:
        return AppStrings.businessCheck;
      case ChequeType.cashiers:
        return AppStrings.cashierCheck;
      case ChequeType.certified:
        return AppStrings.certifiedCheck;
      case ChequeType.bankersDraft:
        return AppStrings.bankerCheck;
      case ChequeType.travelers:
        return AppStrings.travelerCheck;
      case ChequeType.eCheck:
        return AppStrings.eCheck;
      case ChequeType.other:
        return AppStrings.other;
    }
  }
}
