import 'dart:io';
import 'package:a1_check_cashers/features/upload_image/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource remote;

  UploadRepositoryImpl(this.remote);

  @override
  Future<String?> uploadImage(File file, String fieldKey) {
    return remote.uploadImage(file, fieldKey);
  }

  @override
  Future<bool> createDocument(
    String description,
    String frontFileId,
    String backFileId,
    String userId,
  ) {
    return remote.createDocument(description, frontFileId, backFileId, userId);
  }

  @override
  Future<List<Item>> fetchDocuments(String userId) async {
    return await remote.fetchDocuments(userId);
  }

  @override
  Future<bool> updateDocument(
    String docId,
    String description,
    String frontFileId,
    String backFileId,
  ) {
    return remote.updateDocument(docId, description, frontFileId, backFileId);
  }

  @override
  Future<bool> deleteDocuments(String docId) {
    return remote.deleteDocument(docId);
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
    ChequeType type,
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
      chequeType: type.chequeTypeName,
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
    ChequeType type,
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
      chequeType: type.chequeTypeName,
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
