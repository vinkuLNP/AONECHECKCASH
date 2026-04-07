import 'dart:convert';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/features/upload_image/data/models/item_model.dart';
import 'package:http/http.dart' as http;

class UploadRemoteDataSource {
  Future<String?> uploadImage(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiEndpoints.uploadFile),
    );

    request.headers.addAll(ApiHeaders.baseHeaders());
    request.files.add(await http.MultipartFile.fromPath("files", file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      return data["id"];
    }
    return null;
  }

  Future<bool> createDocument(
    String description,
    String fileId,
    String userId,
  ) async {
    final body = {
      KnackFields.description: description,
      KnackFields.image: fileId,
      KnackFields.status: "Pending",
      KnackFields.userId: userId,
    };

    final response = await http.post(
      Uri.parse(ApiEndpoints.documents),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<ItemModel>> fetchDocuments(String userId) async {
    final uri = Uri.parse(ApiEndpoints.documents)
    .replace(
      queryParameters: {
        "filters": jsonEncode([
          {"field": KnackFields.userId, "operator": "is", "value": userId},
        ]),
      },
    );
    final response = await http.get(uri, headers: ApiHeaders.jsonHeaders());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<ItemModel>.from(
        data["records"].map((e) => ItemModel.fromJson(e)),
      );
    }
    return [];
  }

  Future<bool> updateDocument(
    String id,
    String description,
    String fileId,
  ) async {
    final body = {
      KnackFields.description: description,
      KnackFields.image: fileId,
    };

    final response = await http.put(
      Uri.parse("${ApiEndpoints.documents}/$id"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteDocument(String id) async {
    final response = await http.delete(
      Uri.parse("${ApiEndpoints.documents}/$id"),
      headers: ApiHeaders.jsonHeaders(),
    );

    return response.statusCode == 200;
  }
}
