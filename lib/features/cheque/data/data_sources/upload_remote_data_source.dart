import 'dart:convert';
import 'dart:io';
import 'package:a1_check_cashers/core/constants/app_strings.dart';
import 'package:a1_check_cashers/core/constants/knack/api_endpoints.dart';
import 'package:a1_check_cashers/core/constants/knack/api_headers.dart';
import 'package:a1_check_cashers/core/constants/knack/knack_fields.dart';
import 'package:a1_check_cashers/features/cheque/data/models/cheque_model.dart';
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

  Future<List<ChequeModel>> fetchCheques(String userId) async {
    final uri = Uri.parse(ApiEndpoints.cheques).replace(
      queryParameters: {
        "filters": jsonEncode([
          {
            "field": KnackFields.userIdForCheque,
            "operator": "is",
            "value": userId,
          },
        ]),
      },
    );
    final response = await http.get(uri, headers: ApiHeaders.jsonHeaders());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<ChequeModel>.from(
        data["records"].map((e) => ChequeModel.fromJson(e)),
      );
    }
    return [];
  }

  Future<bool> createCheque({
    required String clientId,
    // required String chequeNumber,
    // required double amount,
    // required DateTime date,
    required String frontFileId,
    required String backFileId,
    // required String chequeType,
    required String customerName,
    required String customerPhone,
    // required String payeeName,
    required String makerName,
    required String makerPhone,
    required String chequeDetails,
    String status = AppStrings.underReview,
    String? notes,
  }) async {
    final body = {
      KnackFields.userIdForCheque: [
        {"id": clientId},
      ],

      KnackFields.chequeStatus: status,

      // KnackFields.chequeNumber: chequeNumber,

      // KnackFields.chequeAmount: amount,

      // KnackFields.chequeDate: date.toIso8601String(),

      // KnackFields.chequeType: chequeType,

      KnackFields.customerName: customerName,
      KnackFields.customerPhone: customerPhone,
      // KnackFields.payeeName: payeeName,

      KnackFields.chequeMakerName: makerName,
      KnackFields.makerPhone: makerPhone,

      KnackFields.chequeDetails: chequeDetails,

      KnackFields.chequeFrontImage: frontFileId,

      KnackFields.chequeBackImage: backFileId,
    };

    final response = await http.post(
      Uri.parse(ApiEndpoints.cheques),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> updateCheque({
    required String clientId,
    // required String chequeNumber,
    // required double amount,
    // required DateTime date,
    required String frontFileId,
    required String backFileId,
    // required String chequeType,
    required String customerName,
    required String customerPhone,
    // required String payeeName,
    required String makerName,
    required String makerPhone,
    required String chequeDetails,
    required String status,
    String? notes,
  }) async {
    final body = {
      KnackFields.chequeStatus: status,

      // KnackFields.chequeNumber: chequeNumber,

      // KnackFields.chequeAmount: amount,

      // KnackFields.chequeDate: date.toIso8601String(),

      // KnackFields.chequeType: chequeType,

      KnackFields.customerName: customerName,
      KnackFields.customerPhone: customerPhone,
      // KnackFields.payeeName: payeeName,

      KnackFields.chequeMakerName: makerName,
      KnackFields.makerPhone: makerPhone,

      KnackFields.chequeDetails: chequeDetails,

      KnackFields.chequeFrontImage: frontFileId,

      KnackFields.chequeBackImage: backFileId,

      KnackFields.chequeNotes: notes ?? "",
    };

    final response = await http.put(
      Uri.parse("${ApiEndpoints.cheques}/$clientId"),
      headers: ApiHeaders.jsonHeaders(),
      body: jsonEncode(body),
    );

    return response.statusCode == 200;
  }
}

