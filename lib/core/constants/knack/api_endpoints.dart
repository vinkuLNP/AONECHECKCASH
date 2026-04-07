import 'app_config.dart';
class ApiEndpoints {
  static String login = "$baseUrl/applications/$appId/session";

  static String signup =
      "$baseUrl/objects/$objectKeyUsers/records";

  static String uploadFile =
      "$baseUrl/applications/$appId/assets/file/upload";

  static String documents =
      "$baseUrl/objects/$objectKeyDocuments/records";

  static String updateDocument(String id) =>
      "$baseUrl/objects/$objectKeyDocuments/records/$id";
}