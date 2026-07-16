import 'package:a1_check_cashers/core/app_widgets/app_common_button.dart';
import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:a1_check_cashers/core/app_widgets/input_fields.dart';
import 'package:a1_check_cashers/core/constants/app_colors.dart';
import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
import 'package:a1_check_cashers/core/routes/app_routes.dart';
import 'package:a1_check_cashers/core/session_manager/session_manager.dart';
import 'package:a1_check_cashers/core/utils/file_utils.dart';
import 'package:a1_check_cashers/features/home_page/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    final zipController = TextEditingController();
    return Container(
      color: AppColors.heroColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.heroTitle,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: AppColors.primary,
          ),

          const SizedBox(height: 20),

          const AppText(
            text: AppStrings.heroSubtitle,
            fontSize: 15,
            height: 1.5,
            color: AppColors.textLight,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppInputField(
                  label: "",
                  fillColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  borderColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  focusColor: AppColors.whiteColor.withValues(alpha: 0.7),
                  controller: zipController,
                  hint: AppStrings.enterZip,
                  isDense: true,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Flexible(
                flex: 1,
                child: AppButton(
                  text: AppStrings.findStore,
                  onPressed: () async {
                    final zip = zipController.text.trim();

                    final zipRegex = RegExp(r'^\d{5}$');

                    if (!zipRegex.hasMatch(zip)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid ZIP Code")),
                      );

                      return;
                    }

                    controller.showLoader();

                    try {
                      final url = "${AppStrings.storeLocationsUrl}?zip=$zip";

                      await openUrl(url);
                    } catch (e) {
                      print(e);
                    } finally {
                      controller.hideLoader();
                    }
                  },
                  isOutlined: true,
                  borderColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          GestureDetector(
            onTap: () async {
              controller.showLoader();

              try {
                bool serviceEnabled;
                LocationPermission permission;

                serviceEnabled = await Geolocator.isLocationServiceEnabled();

                if (!serviceEnabled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AppText(text: AppStrings.locationDisabled),
                    ),
                  );

                  controller.hideLoader();
                  return;
                }

                permission = await Geolocator.checkPermission();

                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();

                  if (permission == LocationPermission.denied) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: AppText(text: AppStrings.locationDenied),
                      ),
                    );
                    controller.hideLoader();
                    return;
                  }
                }

                if (permission == LocationPermission.deniedForever) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: AppText(text: AppStrings.locationDeniedForever),
                    ),
                  );
                  controller.hideLoader();
                  return;
                }

                final position = await Geolocator.getCurrentPosition();

                final zip = await getZipFromLatLng(
                  position.latitude,
                  position.longitude,
                );

                final zipRegex = RegExp(r'^\d{5}$');

                if (!zipRegex.hasMatch(zip.toString())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: AppText(text: AppStrings.serviceUnavailable),
                    ),
                  );

                  controller.hideLoader();
                  return;
                }

                if (zip != null && zip.isNotEmpty) {
                  final url = "${AppStrings.storeLocationsUrl}?zip=$zip";

                  await openUrl(url);
                } else {
                  print("ZIP not found");
                }
              } catch (e) {
                print("Location Error: $e");
              } finally {
                controller.hideLoader();
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.near_me_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(width: 6),
                AppText(
                  text: AppStrings.useMyLocation,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                  fontSize: 13,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () => openUrl(AppStrings.storeLocationsUrl),
                  text: AppStrings.getDirections,
                  isOutlined: true,
                  borderColor: AppColors.primary,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  icon: const Icon(
                    Icons.location_on,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  text: AppStrings.verifyCheckNow,
                  isOutlined: true,
                  textColor: AppColors.whiteColor,
                  outlinedColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  icon: const Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                    size: 18,
                  ),
                  onPressed: () async {
                    final isLoggedIn = await SessionManager.isLoggedIn();
                    if (isLoggedIn) {
                      Navigator.pushNamed(context, AppRoutes.profileView);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.login);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Center(
            child: AppText(
              text: AppStrings.tagline,
              fontSize: 13,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> getZipFromLatLng(double lat, double lng) async {
  String apiKey = dotenv.env['API_KEY'] ?? '';
  final url =
      "$geocodeUrl"
      "?latlng=$lat,$lng&key=$apiKey";

  final response = await http.get(Uri.parse(url));

  final data = jsonDecode(response.body);

  if (data["status"] != "OK") {
    return null;
  }

  for (final result in data["results"]) {
    for (final component in result["address_components"]) {
      final types = List<String>.from(component["types"]);

      if (types.contains("postal_code")) {
        return component["long_name"];
      }
    }
  }

  return null;
}
