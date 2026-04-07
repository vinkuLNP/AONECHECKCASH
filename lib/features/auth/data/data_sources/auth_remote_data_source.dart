import 'dart:convert';
import 'dart:developer';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      headers: ApiHeaders.loginHeaders(),
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
      Uri.parse(ApiEndpoints.signup),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode({
        KnackFields.email: email,
        KnackFields.password: password,
        KnackFields.name: {"first": name, "last": ""},
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
