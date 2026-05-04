import 'app_config.dart';

class ApiEndpoints {
  static String login = "$baseUrl/applications/$appId/session";

  static String signup = "$baseUrl/objects/$objectKeyUsers/records";

  // static String uploadFile =
  //     "$baseUrl/applications/$appId/assets/file/upload";

  static String uploadFile =
      "$knackUploadUrl/applications/$appId/assets/image/upload/stream";

  static String idDocuments = "$baseUrl/objects/$objectKeyIdDocuments/records";

  static String updateIdDocument(String id) =>
      "$baseUrl/objects/$objectKeyIdDocuments/records/$id";
}
