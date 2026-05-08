import 'dart:io';
import 'package:a1_check_cashers/features/cheque/domain/entities/cheque_entity.dart';

abstract class UploadRepository {
  Future<String?> uploadImage(File file, String fieldKey);

  Future<List<Cheque>> fetchCheques(String userId);
  Future<bool> createCheque(
    String userId,
    String chequeNumber,
    double amount,
    DateTime date,
    String frontImage,
    String backImage,
    String type,
    String customerName,
    String customerPhone,
    String payeeName,
    String makerName,
    String makerPhone,
    String chequeDetails,
    String status,
    String? notes,
  );
  Future<bool> updateCheque(
    String userId,
    String chequeNumber,
    double amount,
    DateTime date,
    String frontImage,
    String backImage,
    String type,
    String customerName,
    String customerPhone,
    String payeeName,
    String makerName,
    String makerPhone,
    String chequeDetails,
    String status,
    String? notes,
  );
}
