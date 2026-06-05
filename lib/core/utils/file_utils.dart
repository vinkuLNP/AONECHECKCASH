import 'dart:io';

class FileUtils {
  static const int maxSize = 2 * 1024 * 1024;

  static Future<bool> isValidFileSize(File file) async {
    final size = await file.length();
    return size <= maxSize;
  }
}