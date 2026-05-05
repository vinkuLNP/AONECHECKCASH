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
        return "Personal Cheque";
      case ChequeType.business:
        return "Business Cheque";
      case ChequeType.cashiers:
        return "Cashier’s Cheque";
      case ChequeType.certified:
        return "Certified Cheque";
      case ChequeType.bankersDraft:
        return "Banker’s Draft";
      case ChequeType.travelers:
        return "Traveler’s Cheque";
      case ChequeType.eCheck:
        return "Electronic Cheque (eCheck)";
      case ChequeType.other:
        return "Other";
    }
  }
}
