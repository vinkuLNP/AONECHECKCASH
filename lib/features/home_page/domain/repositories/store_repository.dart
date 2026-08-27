import 'package:a1_check_cashers/features/home_page/domain/entities/store_location_entity.dart';

abstract class StoreRepository {
  Future<List<StoreLocation>> getStoreLocations();
}