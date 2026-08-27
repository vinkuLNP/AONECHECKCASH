import 'package:a1_check_cashers/features/home_page/domain/entities/user_location_entity.dart';

abstract class LocationRepository {
  Future<UserLocation> getCurrentLocation();

  Stream<UserLocation> getLocationStream();
}