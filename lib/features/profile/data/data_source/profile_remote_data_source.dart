import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/features/profile/data/models/client_model.dart';
import 'package:http/http.dart' as http;

class ProfileRemoteDataSource {
  Future<ClientModel> fetchProfile(String clientId) async {
    final response = await http.get(
      Uri.parse("${ApiEndpoints.signup}/$clientId"),
      headers: ApiHeaders.jsonHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("PROFILE RESPONSE =====");
      log(data.toString());
      return ClientModel.fromJson(data);
    } else {
      throw Exception("Failed to load profile");
    }
  }

  Future<String?> uploadImage(File file, String fieldKey) async {
    final uri = Uri.parse(ApiEndpoints.uploadFile).replace(
      queryParameters: {
        "fieldKey": fieldKey,
        "filename": file.path.split('/').last,
        "size": (await file.length()).toString(),
        "type": "image/png",
      },
    );

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(ApiHeaders.baseHeaders());

    request.files.add(await http.MultipartFile.fromPath("files", file.path));

    var response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data[0]["id"];
    }
    return null;
  }

  Future<bool> updateUserIdFront({
    required String clientId,
    required String fileId,
  }) async {
    final body = {KnackFields.frontImage: fileId};

    final response = await http.put(
      Uri.parse("${ApiEndpoints.signup}/$clientId"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }
}
