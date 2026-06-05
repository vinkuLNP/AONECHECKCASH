import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/features/profile/data/models/business_check_cashing_form_model.dart';
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

  Future<String?> uploadForm(File file, String fieldKey) async {
    try {
      log("========== PDF UPLOAD START ==========");
      log("File Path: ${file.path}");
      log("Field Key: $fieldKey");

      final fileSize = await file.length();

      log("File Size: $fileSize");

      final uri = Uri.parse(ApiEndpoints.uploadPdfFile).replace(
        queryParameters: {
          "fieldKey": fieldKey,
          "filename": file.path.split('/').last,
          "size": fileSize.toString(),
          "type": "application/pdf",
          // "type": "pdf",
          //
        },
      );

      log("Upload URI: $uri");

      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(ApiHeaders.baseHeaders());

      request.files.add(await http.MultipartFile.fromPath("files", file.path));

      log("Sending Upload Request...");

      final response = await request.send();

      log("Upload Response Status: ${response.statusCode}");

      final res = await http.Response.fromStream(response);

      log("Upload Response Body: ${res.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(res.body);

        final fileId = data["id"];

        log("Uploaded File ID: $fileId");
        log("========== PDF UPLOAD SUCCESS ==========");

        return fileId;
      }

      log("========== PDF UPLOAD FAILED ==========");

      return null;
    } catch (e) {
      log("PDF Upload Error: $e");

      return null;
    }
  }

  Future<bool> createForm({
    required String clientId,
    required String fileId,
  }) async {
    final body = {"field_80": clientId, "field_81": fileId};

    final response = await http.post(
      Uri.parse(ApiEndpoints.businessCheckForm),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updateForm({
    required String recordId,
    required String fileId,
  }) async {
    final body = {"field_81": fileId};

    final response = await http.put(
      Uri.parse("${ApiEndpoints.businessCheckForm}/$recordId"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }

  Future<BusinessCheckFormModel?> fetchForm(String clientId) async {
    try {
      log("Fetching business form for client: $clientId");

      final response = await http.get(
        Uri.parse(
          "${ApiEndpoints.businessCheckForm}"
          "?filters[0][field]=field_80"
          "&filters[0][operator]=is"
          "&filters[0][value]=$clientId"
          "&sort_field=field_74"
          "&sort_order=desc",
        ),
        headers: ApiHeaders.jsonHeaders(),
      );

      log("Fetch Status Code: ${response.statusCode}");
      log("Fetch Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final records = data["records"];

        if (records == null || records.isEmpty) {
          log("No business form found");
          return null;
        }

        final latestRecord = records.first;

        log("Latest Record: $latestRecord");

        return BusinessCheckFormModel.fromJson(latestRecord);
      }

      return null;
    } catch (e) {
      log("Fetch Form Error: $e");
      return null;
    }
  }

  Future<String> downloadEmptyForm() async {
    return "https://123f5cb6-497b-4561-91ba-d5ec09651b52.usrfiles.com/ugd/123f5c_7aacbe6478384482bdeafaf2eaa314d7.pdf";
  }
}
