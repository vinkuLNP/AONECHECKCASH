import 'dart:async';
import 'dart:convert';

import 'package:a1_check_cashers/features/home_page/data/data_sources/store_locations_local_data.dart';
import 'package:a1_check_cashers/features/home_page/domain/entities/store_location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NearestStoreProvider extends ChangeNotifier {
  final  String _googleMapsApiKey =
     dotenv.env['API_KEY'] ?? '';

  // ============================================================
  // CONFIGURATION
  // ============================================================

  /// Number of stores sent to Google for driving distance.
  ///
  /// This is NOT the number shown to the user.
  /// Only ONE store is ultimately selected.
  static const int _googleCandidateLimit = 10;

  /// Minimum distance user must move before we recalculate
  /// driving distances.
  ///
  /// GPS stream itself uses distanceFilter: 100 meters,
  /// but we don't want to call Google on every GPS update.
  static const double _drivingRecalculationDistance = 500;

  // ============================================================
  // STATE
  // ============================================================

  StoreLocation? _nearestStore;

  Position? _currentPosition;

  Position? _lastDrivingCalculationPosition;

  StreamSubscription<Position>? _positionSubscription;

  bool _isLoading = false;

  bool _hasLocationPermission = false;

  bool _isCalculatingDrivingDistance = false;

  // ============================================================
  // GETTERS
  // ============================================================

  StoreLocation? get nearestStore => _nearestStore;

  Position? get currentPosition => _currentPosition;

  bool get isLoading => _isLoading;

  bool get hasLocationPermission => _hasLocationPermission;

  String get nearestZipCode {
    return _nearestStore?.zipCode ?? '';
  }

  // ============================================================
  // START LOCATION TRACKING
  // ============================================================

  Future<void> startLocationTracking() async {
    if (_positionSubscription != null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final hasPermission = await _ensurePermission();

    if (!hasPermission) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      // --------------------------------------------------------
      // Get initial location
      // --------------------------------------------------------

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      await _updateNearestStore(position);

      // --------------------------------------------------------
      // Start location stream
      // --------------------------------------------------------

      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      ).listen((position) async {
        await _updateNearestStore(position);
      });
    } catch (error) {
      debugPrint(
        'NearestStoreProvider location error: $error',
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  // ============================================================
  // PERMISSION
  // ============================================================

  Future<bool> _ensurePermission() async {
    final serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _hasLocationPermission = false;
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _hasLocationPermission = false;
      return false;
    }

    _hasLocationPermission = true;

    return true;
  }

  // ============================================================
  // UPDATE NEAREST STORE
  // ============================================================

  Future<void> _updateNearestStore(
    Position position,
  ) async {
    _currentPosition = position;

    // ----------------------------------------------------------
    // If we already calculated driving distance recently,
    // don't call Google again for every 100m GPS update.
    // ----------------------------------------------------------

    if (_lastDrivingCalculationPosition != null) {
      final distanceMoved = Geolocator.distanceBetween(
        _lastDrivingCalculationPosition!.latitude,
        _lastDrivingCalculationPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      if (distanceMoved <
          _drivingRecalculationDistance) {
        return;
      }
    }

    // ----------------------------------------------------------
    // Prevent multiple Google requests at the same time.
    // ----------------------------------------------------------

    if (_isCalculatingDrivingDistance) {
      return;
    }

    _isCalculatingDrivingDistance = true;

    try {
      final nearest =
          await _findNearestStoreByDrivingDistance(
        position.latitude,
        position.longitude,
      );

      if (nearest?.storeNumber !=
          _nearestStore?.storeNumber) {
        _nearestStore = nearest;

        notifyListeners();
      }

      _lastDrivingCalculationPosition = position;
    } catch (error) {
      debugPrint(
        'Driving distance calculation failed: $error',
      );

      // --------------------------------------------------------
      // Fallback:
      // If Google fails, use straight-line nearest store.
      // --------------------------------------------------------

      final fallback = _findNearestStoreByAirDistance(
        position.latitude,
        position.longitude,
      );

      if (fallback?.storeNumber !=
          _nearestStore?.storeNumber) {
        _nearestStore = fallback;

        notifyListeners();
      }

      _lastDrivingCalculationPosition = position;
    } finally {
      _isCalculatingDrivingDistance = false;
    }
  }

  // ============================================================
  // FIND NEAREST STORE BY DRIVING DISTANCE
  // ============================================================

  Future<StoreLocation?> _findNearestStoreByDrivingDistance(
    double userLat,
    double userLng,
  ) async {
    if (StoreLocations.stores.isEmpty) {
      return null;
    }

    // ==========================================================
    // STEP 1
    // Calculate straight-line distance to ALL stores.
    // ==========================================================

    final storesWithAirDistance =
        StoreLocations.stores.map((store) {
      final airDistance = Geolocator.distanceBetween(
        userLat,
        userLng,
        store.latitude,
        store.longitude,
      );

      return _StoreWithDistance(
        store: store,
        airDistanceMeters: airDistance,
      );
    }).toList();

    // ==========================================================
    // STEP 2
    // Sort by straight-line distance.
    // ==========================================================

    storesWithAirDistance.sort(
      (a, b) => a.airDistanceMeters.compareTo(
        b.airDistanceMeters,
      ),
    );

    // ==========================================================
    // STEP 3
    // Take ONLY 10 closest candidates internally.
    //
    // The user will NOT see these 10.
    // ==========================================================

    final candidates = storesWithAirDistance
        .take(_googleCandidateLimit)
        .toList();

    if (candidates.isEmpty) {
      return null;
    }

    // ==========================================================
    // STEP 4
    // Get actual driving distances from Google.
    // ==========================================================

    final drivingDistances =
        await _getDrivingDistances(
      originLat: userLat,
      originLng: userLng,
      stores: candidates
          .map((item) => item.store)
          .toList(),
    );

    // ==========================================================
    // STEP 5
    // Attach driving distance to each store.
    // ==========================================================

    final storesWithDrivingDistance =
        candidates.map((candidate) {
      final distanceInfo =
          drivingDistances.firstWhere(
        (distance) =>
            distance.storeNumber ==
            candidate.store.storeNumber,
        orElse: () => _DrivingDistanceResult(
          storeNumber: candidate.store.storeNumber,
          distanceMeters: double.infinity,
        ),
      );

      return _StoreWithDistance(
        store: candidate.store,
        airDistanceMeters:
            candidate.airDistanceMeters,
        drivingDistanceMeters:
            distanceInfo.distanceMeters,
      );
    }).toList();

    // ==========================================================
    // STEP 6
    // Sort by ACTUAL driving distance.
    // ==========================================================

    storesWithDrivingDistance.sort(
      (a, b) => a.drivingDistanceMeters.compareTo(
        b.drivingDistanceMeters,
      ),
    );

    // ==========================================================
    // STEP 7
    // RETURN ONLY ONE STORE.
    // ==========================================================

    return storesWithDrivingDistance.first.store;
  }

  // ============================================================
  // FALLBACK - AIR DISTANCE
  // ============================================================

  StoreLocation? _findNearestStoreByAirDistance(
    double userLat,
    double userLng,
  ) {
    if (StoreLocations.stores.isEmpty) {
      return null;
    }

    StoreLocation? nearest;

    double shortestDistance = double.infinity;

    for (final store in StoreLocations.stores) {
      final distance = Geolocator.distanceBetween(
        userLat,
        userLng,
        store.latitude,
        store.longitude,
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearest = store;
      }
    }

    return nearest;
  }

  // ============================================================
  // GOOGLE DRIVING DISTANCE
  // ============================================================

  Future<List<_DrivingDistanceResult>>
      _getDrivingDistances({
    required double originLat,
    required double originLng,
    required List<StoreLocation> stores,
  }) async {
    if (stores.isEmpty) {
      return [];
    }

    // ----------------------------------------------------------
    // Build destinations:
    //
    // latitude,longitude|latitude,longitude|...
    // ----------------------------------------------------------

    final destinationString = stores
        .map(
          (store) =>
              '${store.latitude},${store.longitude}',
        )
        .join('|');

    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/distancematrix/json'
      '?origins=$originLat,$originLng'
      '&destinations=${Uri.encodeComponent(destinationString)}'
      '&mode=driving'
      '&key=$_googleMapsApiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Google Distance Matrix HTTP error: '
        '${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    // ----------------------------------------------------------
    // Google API status
    // ----------------------------------------------------------

    if (data['status'] != 'OK') {
      throw Exception(
        'Google Distance Matrix failed: '
        '${data['status']} '
        '${data['error_message'] ?? ''}',
      );
    }

    final rows = data['rows'];

    if (rows == null || rows.isEmpty) {
      throw Exception(
        'Google returned no distance rows',
      );
    }

    final elements = rows[0]['elements'];

    if (elements == null) {
      throw Exception(
        'Google returned no distance elements',
      );
    }

    // ----------------------------------------------------------
    // Convert Google response into our model.
    // ----------------------------------------------------------

    final results =
        <_DrivingDistanceResult>[];

    for (int i = 0; i < stores.length; i++) {
      final element = elements[i];

      final status = element['status'];

      if (status == 'OK') {
        final distanceMeters =
            element['distance']['value'];

        results.add(
          _DrivingDistanceResult(
            storeNumber:
                stores[i].storeNumber,
            distanceMeters:
                (distanceMeters as num).toDouble(),
          ),
        );
      } else {
        results.add(
          _DrivingDistanceResult(
            storeNumber:
                stores[i].storeNumber,
            distanceMeters:
                double.infinity,
          ),
        );
      }
    }

    return results;
  }

  // ============================================================
  // REFRESH LOCATION
  // ============================================================

  Future<void> refreshLocation() async {
    await _positionSubscription?.cancel();

    _positionSubscription = null;

    _lastDrivingCalculationPosition = null;

    await startLocationTracking();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _positionSubscription?.cancel();

    super.dispose();
  }
}

// ================================================================
// STORE + DISTANCE MODEL
// ================================================================

class _StoreWithDistance {
  final StoreLocation store;

  final double airDistanceMeters;

  final double drivingDistanceMeters;

  _StoreWithDistance({
    required this.store,
    required this.airDistanceMeters,
    this.drivingDistanceMeters = double.infinity,
  });
}

// ================================================================
// DRIVING DISTANCE RESULT
// ================================================================

class _DrivingDistanceResult {
  final String storeNumber;

  final double distanceMeters;

  _DrivingDistanceResult({
    required this.storeNumber,
    required this.distanceMeters,
  });
}