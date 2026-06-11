import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class FileUtils {
  static const int maxSize = 2 * 1024 * 1024;

  static Future<bool> isValidFileSize(File file) async {
    final size = await file.length();
    return size <= maxSize;
  }
}

Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);

  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
