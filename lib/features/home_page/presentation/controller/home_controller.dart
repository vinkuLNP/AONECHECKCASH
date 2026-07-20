import 'dart:convert';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
import 'package:a1_check_cashers/core/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

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
