import 'package:a1_check_cashers/features/home_page/data/data_sources/location_data_source.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/user_location_entity.dart';
import 'package:a1_check_cashers/features/home_page/domain/repositories/location_repository.dart';

class LocationRepositoryImpl
    implements LocationRepository {

  final LocationDataSource dataSource;

  LocationRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<UserLocation> getCurrentLocation() async {
    final position =
        await dataSource.getCurrentPosition();

    return UserLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Stream<UserLocation> getLocationStream() {
    return dataSource
        .getPositionStream()
        .map(
          (position) => UserLocation(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        );
  }
}