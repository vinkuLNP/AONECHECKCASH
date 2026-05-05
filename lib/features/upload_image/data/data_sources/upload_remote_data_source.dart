import 'dart:convert';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/features/upload_image/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadRemoteDataSource {
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

  Future<bool> createDocument(
    String description,
    String frontFileId,
    String backFileId,
    String userId,
  ) async {
    final body = {
      // KnackFields.description: description,
      KnackFields.frontImage: frontFileId,
      KnackFields.backImage: backFileId,
      // KnackFields.status: "Pending",
      KnackFields.userIdForIdDocument: [
        {"id": userId},
      ],
    };

    final url = Uri.parse(ApiEndpoints.idDocuments);

    body.forEach((key, value) {
      debugPrint("   $key: $value");
    });

    try {
      final response = await http.post(
        url,
        headers: ApiHeaders.jsonHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {}
  }

  Future<List<ItemModel>> fetchDocuments(String userId) async {
    final uri = Uri.parse(ApiEndpoints.idDocuments).replace(
      queryParameters: {
        "filters": jsonEncode([
          {
            "field": KnackFields.userIdForIdDocument,
            "operator": "is",
            "value": userId,
          },
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
    String frontFileId,
    String backFileId,
  ) async {
    final body = {
      KnackFields.description: description,
      KnackFields.frontImage: frontFileId,
      KnackFields.backImage: backFileId,
    };

    final response = await http.put(
      Uri.parse("${ApiEndpoints.idDocuments}/$id"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteDocument(String id) async {
    final response = await http.delete(
      Uri.parse("${ApiEndpoints.idDocuments}/$id"),
      headers: ApiHeaders.jsonHeaders(),
    );

    return response.statusCode == 200;
  }
}
