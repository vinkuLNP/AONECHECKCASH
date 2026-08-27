import 'package:a1_check_cashers/features/home_page/data/data_sources/store_locations_local_data.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/store_location_entity.dart';
import 'package:geolocator/geolocator.dart';


class StoreLocationRepository {
  List<StoreLocation> getStores() {
    return StoreLocations.stores;
  }

  Future<Position?> getCurrentPosition() async {
    final serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50,
      ),
    );
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50,
      ),
    );
  }
}