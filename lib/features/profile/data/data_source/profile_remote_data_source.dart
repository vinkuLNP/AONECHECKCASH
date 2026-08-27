import 'dart:convert';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/app_config.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/core/errors/exceptions.dart';
import 'package:a1_check_cashers/features/profile/data/models/business_check_cashing_form_model.dart';
import 'package:a1_check_cashers/features/profile/data/models/client_model.dart';
import 'package:http/http.dart' as http;

class ProfileRemoteDataSource {
  Future<ClientModel> fetchProfile(String clientId) async {
    final response = await http.get(
      Uri.parse("${ApiEndpoints.signup}/$clientId"),
      headers: ApiHeaders.jsonHeaders(),
    );

    if (response.statusCode != 200) {
      throw ApiException(
        statusCode: response.statusCode,
        message: "Failed to fetch profile",
      );
    }

    final data = jsonDecode(response.body);

    if (data is Map && data.containsKey("records")) {
      final records = data["records"] as List;

      if (records.isEmpty) {
        throw ApiException(statusCode: 404, message: "User not found");
      }

      return ClientModel.fromJson(records.first);
    }

    return ClientModel.fromJson(data);
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
    throw ApiException(
      statusCode: response.statusCode,
      message: "Failed to upload image",
    );
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

    if (response.statusCode == 200) {
      return true;
    }

    throw ApiException(statusCode: response.statusCode, message: response.body);
  }

  Future<String?> uploadForm(File file, String fieldKey) async {
    try {
      final fileSize = await file.length();

      final uri = Uri.parse(ApiEndpoints.uploadPdfFile).replace(
        queryParameters: {
          "fieldKey": fieldKey,
          "filename": file.path.split('/').last,
          "size": fileSize.toString(),
          "type": "application/pdf",
        },
      );

      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(ApiHeaders.baseHeaders());

      request.files.add(await http.MultipartFile.fromPath("files", file.path));

      final response = await request.send();

      final res = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(res.body);

        final fileId = data["id"];

        return fileId;
      }

      throw ApiException(
        statusCode: response.statusCode,
        message: 'Failed to upload form',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to upload form');
    }
  }

  Future<bool> createForm({
    required String clientId,
    required String fileId,
  }) async {
    final body = {
      KnackFields.clientId: clientId,
      KnackFields.applicationForm: fileId,
    };

    final response = await http.post(
      Uri.parse(ApiEndpoints.businessCheckForm),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    throw ApiException(statusCode: response.statusCode, message: response.body);
  }

  Future<bool> updateForm({
    required String recordId,
    required String fileId,
  }) async {
    final body = {KnackFields.applicationForm: fileId};

    final response = await http.put(
      Uri.parse("${ApiEndpoints.businessCheckForm}/$recordId"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return true;
    }

    throw ApiException(statusCode: response.statusCode, message: response.body);
  }

  Future<BusinessCheckFormModel?> fetchForm(String clientId) async {
    try {
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final records = data["records"];

        if (records == null || records.isEmpty) {
          return null;
        }

        final latestRecord = records.first;

        return BusinessCheckFormModel.fromJson(latestRecord);
      }

      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    } catch (e) {
      throw ApiException(message: 'Failed to fetch form');
    }
  }

  Future<String> downloadEmptyForm() async {
    return "https://www.aonecheckcashing.com/_files/ugd/123f5c_7aacbe6478384482bdeafaf2eaa314d7.pdf?dn=document.pdf";
  }

  Future<bool> deleteUser({required String recordId}) async {
    final headers = ApiHeaders.jsonHeaders();

    final clientRes = await http.get(
      Uri.parse("${ApiEndpoints.signup}/$recordId"),
      headers: headers,
    );

    if (clientRes.statusCode != 200) {
      throw Exception("Client record not found.");
    }

    final clientData = jsonDecode(clientRes.body);

    final String? email = clientData["field_31_raw"]?["email"]
        ?.toString()
        .toLowerCase()
        .trim();

    if (email == null || email.isEmpty) {
      throw Exception("Client email not found.");
    }

    await _deleteRecordsByClientId(
      objectKey: objectKeyIdCheques,
      clientFieldKey: KnackFields.userIdForCheque,
      clientRecordId: recordId,
    );

    await _deleteRecordsByClientId(
      objectKey: objectKeyBusinessCheckForms,
      clientFieldKey: KnackFields.clientId,
      clientRecordId: recordId,
    );

    final filters = [
      {"field": "field_2", "operator": "is", "value": email},
    ];

    final accountSearchUrl =
        "${ApiEndpoints.accountHolders}"
        "?filters=${Uri.encodeComponent(jsonEncode(filters))}";

    final accountRes = await http.get(
      Uri.parse(accountSearchUrl),
      headers: headers,
    );

    final accountData = jsonDecode(accountRes.body);
    final List accounts = accountData["records"] ?? [];

    final matchedAccounts = accounts.where((r) {
      final accountEmail = r["field_2_raw"]?["email"]
          ?.toString()
          .toLowerCase()
          .trim();

      return accountEmail == email;
    }).toList();

    if (matchedAccounts.isEmpty) {
      throw Exception("No account found for $email");
    }

    if (matchedAccounts.length > 1) {
      throw Exception("Multiple accounts found for $email");
    }

    final accountId = matchedAccounts.first["id"];

    final deleteAccountRes = await http.post(
      Uri.parse("${ApiEndpoints.accountHolders}/delete"),
      headers: headers,
      body: jsonEncode({
        "ids": [accountId],
      }),
    );

    if (deleteAccountRes.statusCode == 200) {
      return true;
    }

    throw Exception("Delete account failed: ${deleteAccountRes.body}");
  }

  Future<void> _deleteRecordsByClientId({
    required String objectKey,
    required String clientFieldKey,
    required String clientRecordId,
  }) async {
    final headers = ApiHeaders.jsonHeaders();

    final filters = [
      {"field": clientFieldKey, "operator": "is", "value": clientRecordId},
    ];

    final searchUrl =
        "${ApiEndpoints.objectKeyUrlForDelete(objectKey)}"
        "?filters=${Uri.encodeComponent(jsonEncode(filters))}";

    final searchRes = await http.get(Uri.parse(searchUrl), headers: headers);

    if (searchRes.statusCode != 200) {
      throw Exception("Failed to search $objectKey");
    }

    final data = jsonDecode(searchRes.body);
    final List records = data["records"] ?? [];

    if (records.isEmpty) return;

    final ids = records.map((r) => r["id"].toString()).toList();

    final deleteUrl = "${ApiEndpoints.objectKeyUrlForDelete(objectKey)}/delete";

    final deleteRes = await http.post(
      Uri.parse(deleteUrl),
      headers: headers,
      body: jsonEncode({"ids": ids}),
    );

    if (deleteRes.statusCode != 200) {
      throw Exception("Failed to delete $objectKey records");
    }
  }
}
