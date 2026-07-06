import 'package:a1_check_cashers/features/profile/domain/enitites/business_check_cashing_entity.dart';

class BusinessCheckFormModel extends BusinessCheckFormEntity {
  BusinessCheckFormModel({
    required super.id,
    required super.fileId,
    required super.fileUrl,
    required super.fileName,
    required super.createdDate,
  });

  factory BusinessCheckFormModel.fromJson(Map<String, dynamic> json) {
    final fileData = json["field_81_raw"] ?? {};

    return BusinessCheckFormModel(
      id: json["id"].toString(),

      fileId: fileData["id"] ?? '',

      fileName: fileData["filename"] ?? '',

      fileUrl: fileData["url"] ?? fileData["signed_url"] ?? '',
      createdDate: json["field_82"] != null
          ? DateTime.tryParse(json["field_82"])
          : null,
    );
  }
}
