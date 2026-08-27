import 'package:geolocator/geolocator.dart';

class LocationDataSource {
  Future<Position> getCurrentPosition() async {
    final serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'Location services are disabled.',
      );
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception(
        'Location permission denied.',
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission permanently denied.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  Stream<Position> getPositionStream() {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return Geolocator.getPositionStream(
      locationSettings: settings,
    );
  }
}