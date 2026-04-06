import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final String appId = "69c0e18a8116b36bb6987016";
  final String apiKey = "74a47d63-f749-410e-8020-2ecfe5fe4c4d";

  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("https://api.knack.com/v1/applications/$appId/session"),
      headers: {
        "X-Knack-Application-Id": appId,
        "X-Knack-REST-API-Key": "knack",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    log("STATUS: ${response.statusCode}");
    log("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return UserModel.fromJson(body);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<UserModel> signup(String email, String password, String name) async {
    final response = await http.post(
      Uri.parse("https://api.knack.com/v1/objects/object_4/records"),
      headers: {
        "X-Knack-Application-Id": appId,
        "X-Knack-REST-API-Key": apiKey,
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "field_31": email,
        "field_32": password,
        "field_30": {"first": name, "last": ""},
      }),
    );
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return await login(email, password);
    } else {
      log(response.body.toString());

      throw Exception("Signup failed");
    }
  }
}
