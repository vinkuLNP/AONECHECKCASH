import 'package:a1_check_cashers/features/upload_image/domain/entities/item_entity.dart';
import 'package:intl/intl.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.fileId,
    required super.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    String imageUrl = "";
    String fileId = "";
    String createdAt = "";
    final imageRaw = json["field_39_raw"];
    final dateRaw = json["field_32_raw"];
    if (imageRaw is Map) {
      imageUrl = imageRaw["signed_url_inline"] ?? imageRaw["url"] ?? "";
      fileId = imageRaw["id"] ?? "";
    }
    if (dateRaw is Map && dateRaw["iso_timestamp"] != null) {
      DateTime utcTime = DateTime.parse(dateRaw["iso_timestamp"]);
      DateTime localTime = utcTime.toLocal();
      createdAt = DateFormat("dd MMM yyyy, hh:mm a").format(localTime);
    }

    return ItemModel(
      id: json["id"].toString(),
      description: json["field_37"] ?? "",
      imageUrl: imageUrl,
      status: json["field_40"] ?? "Pending",
      fileId: fileId,
      createdAt: createdAt,
    );
  }
}
