import 'package:a1_check_cashers/features/home_page/data/data_sources/location_data_source.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/store_location_entity.dart';

import 'get_nearest_store.dart';

// class WatchNearestStore {
//   final LocationDataSource locationDataSource;
//   final GetNearestStore getNearestStore;

//   WatchNearestStore({
//     required this.locationDataSource,
//     required this.getNearestStore,
//   });

//   Stream<StoreLocation?> execute() {
//     return locationDataSource
//         .getPositionStream()
//         .map((position) {
//       return getNearestStore.execute(
//         userLatitude: position.latitude,
//         userLongitude: position.longitude,
//       );
//     });
//   }
// }