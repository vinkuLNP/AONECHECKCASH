import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.description,
    required super.status,
    required super.frontFileId,
    required super.backFileId,
    required super.frontImageUrl,
    required super.backImageUrl,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    String frontImageUrl = "";
    String backImageUrl = "";

    String frontFileId = "";
    String backFileId = "";

    final frontRaw = json["field_62_raw"];

    if (frontRaw is Map) {
      frontImageUrl = frontRaw["signed_url_inline"] ?? frontRaw["url"] ?? "";
      frontFileId = frontRaw["id"] ?? "";
    }

    /// BACK IMAGE
    final backRaw = json["field_63_raw"];

    if (backRaw is Map) {
      backImageUrl = backRaw["signed_url_inline"] ?? backRaw["url"] ?? "";
      backFileId = backRaw["id"] ?? "";
    }
    return ItemModel(
      id: json["id"].toString(),
      description: json["field_37"] ?? "",
      frontImageUrl: frontImageUrl,
      backImageUrl: backImageUrl,
      frontFileId: frontFileId,
      backFileId: backFileId,

      status: json["field_40"] ?? "Pending",
    );
  }
}
