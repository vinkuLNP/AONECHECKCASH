import 'package:a1_check_cashers/features/cheque/domain/entities/cheque_entity.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_status_enum.dart';
import 'package:a1_check_cashers/features/cheque/domain/enum/cheque_type_enum.dart';

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
    required super.frontImageId,
    required super.backImageId,
    super.notes,
    super.otherChequeType,
  });
  static double _parseAmount(dynamic value) {

    if (value == null) return 0;

    final cleaned = value
        .toString()
        .replaceAll("\$", "")
        .replaceAll(",", "")
        .trim();

    final parsed = double.tryParse(cleaned) ?? 0;

    return parsed;
  }

  static DateTime _parseDate(dynamic value) {

    if (value is Map) {
      final iso = value["iso_timestamp"];

      if (iso != null) {
        final parsed = DateTime.tryParse(iso);

        return parsed ?? DateTime.now();
      }
    }

    return DateTime.now();
  }

  factory ChequeModel.fromJson(Map<String, dynamic> json) {
    String frontImageUrl = "";
    String backImageUrl = "";
    String? frontImageUrlId;
    String? backImageUrlId;
    final frontRaw = json["field_47_raw"];
    if (frontRaw is Map) {
      frontImageUrl = frontRaw["signed_url_inline"] ?? frontRaw["url"] ?? "";
      frontImageUrlId = frontRaw["id"];
    }
    final backRaw = json["field_48_raw"];

    if (backRaw is Map) {
      backImageUrl = backRaw["signed_url_inline"] ?? backRaw["url"] ?? "";
      backImageUrlId = backRaw["id"];
    }
    final parsedStatus = _parseStatus(json["field_51"]);
    final rawType = json["field_44"]?.toString() ?? "";

    final parsedTypeData = _parseChequeType(rawType);

    final parsedType = parsedTypeData.type;
    final otherType = parsedTypeData.otherType;

    final cheque = ChequeModel(
      id: json["id"].toString(),

      client: json["field_59"] ?? "",

      status: parsedStatus,

      chequeNumber: json["field_23"] ?? "",

      amount: _parseAmount(json["field_42"]),

      chequeDate: _parseDate(json["field_43_raw"]),

      createdAt: _parseDate(json["field_50_raw"]),
      frontImageId: frontImageUrlId,
      backImageId: backImageUrlId,
      type: parsedType,
      otherChequeType: otherType,

      customerName: json["field_67"] ?? "",
      customerPhone: json["field_68_raw"]?["full"]?.toString() ?? "",

      makerPhone: json["field_69_raw"]?["full"]?.toString() ?? "",
      payee: json["field_70"] ?? "",
      makerName: json["field_45"] ?? "",
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

  static ParsedChequeType _parseChequeType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ParsedChequeType(type: ChequeType.other);
    }

    for (final type in ChequeType.values) {
      if (type.chequeTypeName.toLowerCase() == value.toLowerCase()) {
        return ParsedChequeType(type: type);
      }
    }

    return ParsedChequeType(type: ChequeType.other, otherType: value);
  }
}

class ParsedChequeType {
  final ChequeType type;
  final String? otherType;

  ParsedChequeType({required this.type, this.otherType});
}
