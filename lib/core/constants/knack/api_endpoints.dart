import 'package:a1_check_cashers/core/constants/app_strings.dart';

import 'app_config.dart';

class ApiEndpoints {
  static String login = "$baseUrl/applications/$appId/session";

  static String signup = "$baseUrl/objects/$objectKeyUsers/records";
  static String accountHolders =
      "$baseUrl/objects/$objectKeyAccountHolders/records";

  static String uploadFile =
      "$knackUploadUrl/applications/$appId/assets/image/upload/stream";

  static const uploadPdfFile =
      "$knackUploadUrl/applications/$appId/assets/file/upload";

  static String idDocuments = "$baseUrl/objects/$objectKeyIdDocuments/records";
  static String cheques = "$baseUrl/objects/$objectKeyIdCheques/records";

  static String updateIdDocument(String id) =>
      "$baseUrl/objects/$objectKeyIdDocuments/records/$id";
  static String businessCheckForm =
      "$baseUrl/objects/$objectKeyBusinessCheckForms/records";

  static String geocodeByLatLng({
    required double lat,
    required double lng,
    required String apiKey,
  }) {
    return "$geocodeUrl?latlng=$lat,$lng&key=$apiKey";
  }
    static String objectKeyUrlForDelete(String objectKey) =>
 "$baseUrl/objects/$objectKey/records";
  static String storeLocationByZip(String zip) {
    return "${AppStrings.storeLocationsUrl}?zip=$zip";
  }
}
