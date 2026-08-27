class BusinessCheckFormEntity {
  final String id;
  final String? fileId;
  final String? fileUrl;
  final String? fileName;
  final DateTime? createdDate;

  BusinessCheckFormEntity({
    required this.id,
    required this.fileId,
    required this.fileUrl,
    required this.fileName,
    required this.createdDate,
  });
}
