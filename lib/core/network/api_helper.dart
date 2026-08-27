import 'dart:convert';
import 'package:a1_check_cashers/core/errors/exceptions.dart';
import 'package:http/http.dart';

class ApiHelper {
  ApiHelper._();

  static void validate(Response response) {
    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: _extractMessage(response),
    );
  }

  static String _extractMessage(Response response) {
    try {
      final body = jsonDecode(response.body);

      if (body is Map) {
        if (body["errors"] != null) {
          return body["errors"].toString();
        }

        if (body["error"] != null) {
          return body["error"].toString();
        }

        if (body["message"] != null) {
          return body["message"].toString();
        }
      }
    } catch (_) {}

    return response.body.isEmpty
        ? "Something went wrong."
        : response.body;
  }
}