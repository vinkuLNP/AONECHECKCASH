import 'package:a1_check_cashers/features/upload_image/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/upload_image/domain/enum/cheque_type_enum.dart';
import 'package:flutter/material.dart';

class ChequeModel extends Cheque {
  ChequeModel({
    required super.id,
    required super.client,
    required super.status,
    required super.chequeNumber,
    required super.amount,
    required super.chequeDate,
    required super.createdAt,
    required super.type,
    required super.frontImage,
    required super.backImage,
    required super.customerName,
    required super.customerPhone,
    required super.payee,
    required super.makerName,
    required super.makerPhone,
    required super.chequeDetails,
    super.notes,
  });
static double _parseAmount(dynamic value) {
  debugPrint("Parsing Amount Raw: $value");

  if (value == null) return 0;

  final cleaned = value
      .toString()
      .replaceAll("\$", "")
      .replaceAll(",", "")
      .trim();

  debugPrint("Cleaned Amount: $cleaned");

  final parsed = double.tryParse(cleaned) ?? 0;

  debugPrint("Parsed Amount Result: $parsed");

  return parsed;
}

static DateTime _parseDate(dynamic value) {
  debugPrint("Parsing Date Raw: $value");

  if (value is Map) {
    final iso = value["iso_timestamp"];

    debugPrint("ISO Timestamp: $iso");

    if (iso != null) {
      final parsed = DateTime.tryParse(iso);

      debugPrint("Parsed Date Result: $parsed");

      return parsed ?? DateTime.now();
    }
  }

  return DateTime.now();
}
 
  factory ChequeModel.fromJson(Map<String, dynamic> json) {
    String frontImageUrl = "";
    String backImageUrl = "";
    final frontRaw = json["field_47_raw"];
    if (frontRaw is Map) {
      frontImageUrl = frontRaw["signed_url_inline"] ?? frontRaw["url"] ?? "";
    }
    final backRaw = json["field_48_raw"];

    if (backRaw is Map) {
      backImageUrl = backRaw["signed_url_inline"] ?? backRaw["url"] ?? "";
    }
    final parsedStatus = _parseStatus(json["field_51"]);

    final parsedType = _parseChequeType(json["field_44"]);

    final cheque = ChequeModel(
      id: json["id"].toString(),

      client: json["field_59"] ?? "",

      status: parsedStatus,

      chequeNumber: json["field_23"] ?? "",

      amount: _parseAmount(json["field_42"]),


      chequeDate:_parseDate(json["field_43_raw"]),


      createdAt:  _parseDate(json["field_50_raw"]),

      type: parsedType,

   customerName: json["field_67"] ?? "",
      customerPhone: json["field_68"] ?? "",
      payee: json["field_70"] ?? "",
      makerName: json["field_45"] ?? "",
      makerPhone: json["field_69"] ?? "",
      chequeDetails: json["field_71"] ?? "",

      frontImage: frontImageUrl,

      backImage: backImageUrl,

      notes: json["field_46"],
    );

    return cheque;
  }

  static ChequeStatus _parseStatus(String? value) {
    return ChequeStatus.values.firstWhere(
      (e) => e.status.toLowerCase() == value?.toLowerCase(),
      orElse: () => ChequeStatus.underReview,
    );
  }

  static ChequeType _parseChequeType(String? value) {
    return ChequeType.values.firstWhere(
      (e) => e.chequeTypeName.toLowerCase() == value?.toLowerCase(),
      orElse: () => ChequeType.other,
    );
  }
}
