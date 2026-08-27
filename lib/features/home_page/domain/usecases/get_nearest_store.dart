import 'package:a1_check_cashers/features/home_page/domain/entities/store_location_entity.dart';

// class GetNearestStore {
//   StoreLocation? execute({
//     required double userLatitude,
//     required double userLongitude,
//   }) {
//     if (StoreLocations.stores.isEmpty) {
//       return null;
//     }

//     StoreLocation? nearestStore;
//     double shortestDistance = double.infinity;

//     for (final store in StoreLocations.stores) {
//       final distance = Geolocator.distanceBetween(
//         userLatitude,
//         userLongitude,
//         store.latitude,
//         store.longitude,
//       );

//       if (distance < shortestDistance) {
//         shortestDistance = distance;
//         nearestStore = store;
//       }
//     }

//     return nearestStore;
//   }
// }
import 'dart:math';


class GetNearestStore {
  StoreLocation? call({
    required double userLatitude,
    required double userLongitude,
    required List<StoreLocation> stores,
  }) {
    if (stores.isEmpty) {
      return null;
    }

    StoreLocation? nearestStore;
    double shortestDistance = double.infinity;

    for (final store in stores) {
      final distance = _calculateDistance(
        userLatitude,
        userLongitude,
        store.latitude,
        store.longitude,
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearestStore = store;
      }
    }

    return nearestStore;
  }

  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadius = 6371.0;

    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);

    final a =
        pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            pow(sin(dLng / 2), 2);

    final c = 2 * atan2(
      sqrt(a),
      sqrt(1 - a),
    );

    return earthRadius * c;
  }

  double _toRadians(double value) {
    return value * (pi / 180);
  }
}