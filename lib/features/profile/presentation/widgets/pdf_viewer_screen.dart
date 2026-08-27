import 'dart:io';

import 'package:a1_check_cashers/core/app_widgets/app_common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class BusinessPdfViewerScreen extends StatefulWidget {
  final String? pdfUrl;
  final String title;
  final String? pdfPath;
  final bool isLocal;
  const BusinessPdfViewerScreen({
    super.key,
    this.pdfUrl,
    required this.title,
    this.pdfPath,
    required this.isLocal,
  });

  @override
  State<BusinessPdfViewerScreen> createState() =>
      _BusinessPdfViewerScreenState();
}

class _BusinessPdfViewerScreenState extends State<BusinessPdfViewerScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    if (widget.isLocal) {
      setState(() {
        localPath = widget.pdfPath;
      });

      return;
    }
    final response = await http.get(Uri.parse(widget.pdfUrl!));

    final dir = await getTemporaryDirectory();

    final file = File("${dir.path}/temp.pdf");

    await file.writeAsBytes(response.bodyBytes);

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(text:widget.title)),
      body: localPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPath!),
    );
  }
}
