import 'app_config.dart';

class ApiHeaders {
  static Map<String, String> baseHeaders() => {
    "X-Knack-Application-Id": appId,
    "X-Knack-REST-API-Key": apiKey,
  };

  static Map<String, String> jsonHeaders() => {
    ...baseHeaders(),
    "Content-Type": "application/json",
  };

  static Map<String, String> loginHeaders() => {
    "X-Knack-Application-Id": appId,
    "X-Knack-REST-API-Key": "knack",
    "Content-Type": "application/json",
  };
}
