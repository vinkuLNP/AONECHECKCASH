import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';

class Cheque {
  final String id;
  final String client;
  final ChequeStatus status;
  final String chequeNumber;
  final double amount;
  final DateTime chequeDate;
  final DateTime createdAt;

  final ChequeType type;
  final String companyName;
  final String frontImage;
  final String backImage;
  final String? notes;

  Cheque({
    required this.id,
    required this.client,
    required this.status,
    required this.chequeNumber,
    required this.amount,
    required this.chequeDate,
    required this.createdAt,
    required this.type,
    required this.companyName,
    required this.frontImage,
    required this.backImage,
    this.notes,
  });
}
