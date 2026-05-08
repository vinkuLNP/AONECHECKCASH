import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/repositories/upload_repository.dart';

class CreateChequeUsecase {
  final UploadRepository repo;
  CreateChequeUsecase(this.repo);

  Future<bool> call(
    String userId,
    String chequeNumber,
    double amount,
    DateTime date,
    String frontImage,
    String backImage,
    ChequeType type,
    String customerName,
    String customerPhone,
    String payeeName,
    String makerName,
    String makerPhone,
    String chequeDetails,
    String status,
    String? notes,
  ) => repo.createCheque(
    userId,
    chequeNumber,
    amount,
    date,
    frontImage,
    backImage,
    type,
    customerName,
    customerPhone,
    payeeName,
    makerName,
    makerPhone,
    chequeDetails,
    status,
    notes,
  );
}
