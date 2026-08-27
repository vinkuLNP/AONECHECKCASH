class StoreLocation {
  final String id;
  final String storeNumber;
  final String storeAddress;
  final String zipCode;
  final double latitude;
  final double longitude;
  final String? directionLink;

  const StoreLocation({
    required this.id,
    required this.storeNumber,
    required this.storeAddress,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    this.directionLink,
  });
}
