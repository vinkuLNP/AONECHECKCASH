import 'dart:convert';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
import 'package:a1_check_cashers/core/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:convert';

// import 'package:a1_check_cashers/core/constants/app_strings.dart';
// import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
// import 'package:a1_check_cashers/core/utils/file_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;

// import '../../domain/usecases/get_nearest_store.dart';

// class HomeController extends ChangeNotifier {
//   // ============================================================
//   // DEPENDENCIES
//   // ============================================================

//   // final StoreLocationRepository _storeRepository =
//   //     StoreLocationRepository();

//   // final GetNearestStore _getNearestStore =
//   //     GetNearestStore();

//   // StreamSubscription<Position>? _locationSubscription;

//   // ============================================================
//   // LOADING
//   // ============================================================

//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   // ============================================================
//   // NEAREST STORE
//   // ============================================================

//   StoreLocation? _nearestStore;

//   StoreLocation? get nearestStore => _nearestStore;

//   String get nearestStoreZip =>
//       _nearestStore?.zipCode ?? '';

//   // ============================================================
//   // ZIP
//   // ============================================================

//   final zipRegex = RegExp(r'^\d{5}$');

//   bool isValidZip(String zip) {
//     return zipRegex.hasMatch(zip);
//   }

//   // ============================================================
//   // LOADER
//   // ============================================================

//   void showLoader() {
//     _isLoading = true;
//     notifyListeners();
//   }

//   void hideLoader() {
//     _isLoading = false;
//     notifyListeners();
//   }

//   // ============================================================
//   // START CONTINUOUS LOCATION MONITORING
//   // ============================================================

//   Future<void> initializeNearestStore() async {
//     try {
//       final permissionGranted =
//           await _ensureLocationPermission();

//       if (!permissionGranted) {
//         return;
//       }

//       // --------------------------------------------------------
//       // Get initial location
//       // --------------------------------------------------------

//       final position =
//           await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       _updateNearestStore(position);

//       // --------------------------------------------------------
//       // Listen continuously for location changes
//       // --------------------------------------------------------

//       await _locationSubscription?.cancel();

//       _locationSubscription =
//           _storeRepository.getPositionStream().listen(
//         (Position position) {
//           _updateNearestStore(position);
//         },
//       );
//     } catch (error) {
//       debugPrint(
//         'Nearest store initialization error: $error',
//       );
//     }
//   }

//   // ============================================================
//   // UPDATE NEAREST STORE
//   // ============================================================

//   void _updateNearestStore(Position position) {
//     final lat = position.latitude;
//     final lng = position.longitude;

//     if (!isValidUSLatLng(lat, lng)) {
//       debugPrint(
//         'User location is outside supported US area.',
//       );

//       return;
//     }

//     final stores = _storeRepository.getStores();

//     final nearest = _getNearestStore(
//       userLatitude: lat,
//       userLongitude: lng,
//       stores: stores,
//     );

//     if (nearest == null) {
//       return;
//     }

//     // Only notify UI when the actual nearest store changes.
//     if (_nearestStore?.storeNumber !=
//         nearest.storeNumber) {
//       _nearestStore = nearest;

//       debugPrint(
//         'Nearest store: ${nearest.storeNumber}',
//       );

//       debugPrint(
//         'Nearest ZIP: ${nearest.zipCode}',
//       );

//       notifyListeners();
//     }
//   }

//   // ============================================================
//   // LOCATION PERMISSION
//   // ============================================================

//   Future<bool> _ensureLocationPermission() async {
//     final serviceEnabled =
//         await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return false;
//     }

//     var permission =
//         await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission =
//           await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.denied) {
//       return false;
//     }

//     if (permission ==
//         LocationPermission.deniedForever) {
//       return false;
//     }

//     return true;
//   }

//   // ============================================================
//   // ZIP SEARCH
//   // ============================================================

//   Future<Map<String, double>?> getLatLngFromZip(
//     String zip,
//   ) async {
//     final apiKey =
//         dotenv.env['API_KEY'] ?? '';

//     final response = await http.get(
//       Uri.parse(
//         "$geocodeUrl?address=$zip&key=$apiKey",
//       ),
//     );

//     final data =
//         jsonDecode(response.body);

//     if (data["status"] != "OK") {
//       return null;
//     }

//     final location =
//         data["results"][0]["geometry"]["location"];

//     return {
//       "lat": location["lat"],
//       "lng": location["lng"],
//     };
//   }

//   Future<void> searchStoreByZip(
//     BuildContext context,
//     String zip,
//   ) async {
//     if (!isValidZip(zip)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Invalid ZIP Code"),
//         ),
//       );

//       return;
//     }

//     showLoader();

//     try {
//       final location =
//           await getLatLngFromZip(zip);

//       if (location == null) {
//         throw Exception();
//       }

//       final lat = location["lat"]!;
//       final lng = location["lng"]!;

//       if (!isValidUSLatLng(lat, lng)) {
//         throw Exception();
//       }

//       await openUrl(
//         "${AppStrings.storeLocationsUrl}?lat=$lat&lng=$lng",
//       );
//     } catch (_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Services of A1 Check Cashers are not available near your location.",
//           ),
//         ),
//       );
//     } finally {
//       hideLoader();
//     }
//   }

//   // ============================================================
//   // CURRENT LOCATION BUTTON
//   // ============================================================

//   Future<void> useCurrentLocation(
//     BuildContext context,
//   ) async {
//     showLoader();

//     try {
//       final hasPermission =
//           await _ensureLocationPermission();

//       if (!hasPermission) {
//         return;
//       }

//       final position =
//           await Geolocator.getCurrentPosition();

//       final lat = position.latitude;
//       final lng = position.longitude;

//       if (!isValidUSLatLng(lat, lng)) {
//         throw Exception();
//       }

//       await openUrl(
//         "${AppStrings.storeLocationsUrl}?lat=$lat&lng=$lng",
//       );
//     } catch (_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Services of A1 Check Cashers are not available in your area",
//           ),
//         ),
//       );
//     } finally {
//       hideLoader();
//     }
//   }

//   // ============================================================
//   // US LOCATION VALIDATION
//   // ============================================================

//   bool isValidUSLatLng(
//     double lat,
//     double lng,
//   ) {
//     return lat >= 18 &&
//         lat <= 72 &&
//         lng >= -170 &&
//         lng <= -66;
//   }

//   // ============================================================
//   // DISPOSE
//   // ============================================================

//   @override
//   void dispose() {
//     _locationSubscription?.cancel();
//     super.dispose();
//   }
// }
class HomeController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  final zipRegex = RegExp(r'^\d{5}$');

  void showLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }

  bool isValidZip(String zip) => zipRegex.hasMatch(zip);

  bool isValidUSLatLng(double lat, double lng) {
    return lat >= 18 && lat <= 72 && lng >= -170 && lng <= -66;
  }

  Future<Map<String, double>?> getLatLngFromZip(String zip) async {
    final apiKey = dotenv.env['API_KEY'] ?? '';

    final response = await http.get(
      Uri.parse("$geocodeUrl?address=$zip&key=$apiKey"),
    );

    final data = jsonDecode(response.body);

    if (data["status"] != "OK") {
      return null;
    }

    final location = data["results"][0]["geometry"]["location"];

    return {"lat": location["lat"], "lng": location["lng"]};
  }

  Future<void> searchStoreByZip(BuildContext context, String zip) async {
    if (!isValidZip(zip)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid ZIP Code")));
      return;
    }

    showLoader();

    try {
      final location = await getLatLngFromZip(zip);

      if (location == null) {
        throw Exception();
      }

      final lat = location["lat"]!;
      final lng = location["lng"]!;

      if (!isValidUSLatLng(lat, lng)) {
        throw Exception();
      }

      await openUrl("${AppStrings.storeLocationsUrl}?lat=$lat&lng=$lng");
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Services of A1 Check Cashers are not available near your location.",
          ),
        ),
      );
    } finally {
      hideLoader();
    }
  }

  Future<bool> ensureLocationPermission(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Location services are disabled."),
          action: SnackBarAction(
            label: "Enable",
            onPressed: () {
              Geolocator.openLocationSettings();
            },
          ),
        ),
      );
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Location permission is permanently denied."),
          action: SnackBarAction(
            label: "Settings",
            onPressed: () {
              Geolocator.openAppSettings();
            },
          ),
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> useCurrentLocation(BuildContext context) async {
    showLoader();

    try {
      final hasPermission = await ensureLocationPermission(context);

      if (!hasPermission) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      final lat = position.latitude;
      final lng = position.longitude;

      if (!isValidUSLatLng(lat, lng)) {
        throw Exception();
      }

      await openUrl("${AppStrings.storeLocationsUrl}?lat=$lat&lng=$lng");
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Services of A1 Check Cashers are not available in your area",
          ),
        ),
      );
    } finally {
      hideLoader();
    }
  }
}
