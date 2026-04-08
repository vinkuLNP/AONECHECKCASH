import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.fileId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = "";
    String fileId = "";

    final imageRaw = json["field_39_raw"];

    if (imageRaw is Map) {
      imageUrl = imageRaw["signed_url_inline"] ?? imageRaw["url"] ?? "";
      fileId = imageRaw["id"] ?? ""; // 🔥 IMPORTANT (this is actual fileId)
    }

    return ItemModel(
      id: json["id"].toString(),
      description: json["field_37"] ?? "",
      imageUrl: imageUrl,
      status: json["field_40"] ?? "Pending",
      fileId: fileId,
    );
  }
}
