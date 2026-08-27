
class Client {
  final String id;
  final String name;
  final String email;
  final String? idFrontImage;

  Client({
    required this.id,
    required this.name,
    required this.email,
    this.idFrontImage,
  });
}
