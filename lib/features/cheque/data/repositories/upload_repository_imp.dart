import 'dart:io';
import 'package:a1_check_cashers/features/cheque/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/cheque/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/cheque/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource remote;

  UploadRepositoryImpl(this.remote);

  @override
  Future<String?> uploadImage(File file, String fieldKey) {
    return remote.uploadImage(file, fieldKey);
  }

  @override
  Future<List<Cheque>> fetchCheques(String userId) async {
    return await remote.fetchCheques(userId);
  }

  @override
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
  ) {
    return remote.createCheque(
      clientId: userId,
      chequeNumber: chequeNumber,
      amount: amount,
      date: date,
      frontFileId: frontImage,
      backFileId: backImage,
      chequeType: type,
      customerName: customerName,
      customerPhone: customerPhone,
      payeeName: payeeName,
      makerName: makerName,
      makerPhone: makerPhone,
      chequeDetails: chequeDetails,
      notes: notes,
      status: status,
    );
  }

  @override
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
  ) {
    return remote.updateCheque(
      clientId: userId,
      chequeNumber: chequeNumber,
      amount: amount,
      date: date,
      frontFileId: frontImage,
      backFileId: backImage,
      chequeType: type,
      status: status,
      notes: notes,
      customerName: customerName,
      customerPhone: customerPhone,
      payeeName: payeeName,
      makerName: makerName,
      makerPhone: makerPhone,
      chequeDetails: chequeDetails,
    );
  }
}
