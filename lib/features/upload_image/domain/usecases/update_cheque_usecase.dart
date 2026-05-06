import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UpdateChequeUsecase {
  final UploadRepository repo;
  UpdateChequeUsecase(this.repo);

  Future<bool> call(
    String userId,
    String chequeNumber,
    double amount,
    DateTime date,
    String companyName,
    String frontImage,
    String backImage,
    ChequeType type,
    String status,
    String? notes,

  ) => repo.updateCheque(
    userId,
    chequeNumber,
    amount,
    date,
    companyName,
    frontImage,
    backImage,
    type,
    status,
    notes,

  );
}
