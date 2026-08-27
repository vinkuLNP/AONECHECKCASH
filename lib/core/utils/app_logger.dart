import 'dart:developer';

class AppLogger {
  AppLogger._();

  static logString(String message) {
    log("📌 LOG: $message");
  }

  static void info(Object? message) {
    log("ℹ️ $message");
  }

  static void warning(Object? message) {
    log("⚠️ $message");
  }

  static void error(Object? message) {
    log("❌ ERROR: $message");
  }
}
