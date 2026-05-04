class Item {
  String id;
  String description;
  String status;
  final String frontImageUrl;
  final String backImageUrl;
  final String frontFileId;
  final String backFileId;

  Item({
    required this.id,
    required this.description,
    required this.status,
    required this.frontImageUrl,
    required this.backImageUrl,
    required this.frontFileId,
    required this.backFileId,
  });
}
