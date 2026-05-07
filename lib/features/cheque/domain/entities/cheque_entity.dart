import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';

class Cheque {
  final String id;
  final String client;
  final String customerName;
  final String customerPhone;
  final ChequeType type;
  final String chequeNumber;
  final double amount;
  final DateTime chequeDate;
  final String chequeDetails;
  final String frontImage;
  final String backImage;
  final String makerName;
  final String makerPhone;
  final String payee;
  final ChequeStatus status;
  final String? notes;
  final DateTime createdAt;

  Cheque({
    required this.id,
    required this.client,
    required this.status,
    required this.chequeNumber,
    required this.amount,
    required this.chequeDate,
    required this.createdAt,
    required this.type,
    required this.frontImage,
    required this.backImage,
    required this.customerName,
    required this.customerPhone,
    required this.payee,
    required this.makerName,
    required this.makerPhone,
    required this.chequeDetails,
    this.notes,
  });
}
