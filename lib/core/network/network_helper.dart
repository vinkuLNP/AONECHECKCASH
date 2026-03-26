import 'package:a1_check_cashers/core/utils/app_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  static Future<bool> isOnline() async {
    try {
      final result = await Connectivity().checkConnectivity();
      AppLogger.logString("NetworkHelper🌐 NetworkHelper Connectivity result: $result");
      final isOffline = result.contains(ConnectivityResult.none);
      AppLogger.logString("NetworkHelper📡 Is Offline: $isOffline");
      final isOnline = !isOffline;
      AppLogger.logString("✅ Is Online: $isOnline");
      return isOnline;
    } catch (e) {
      AppLogger.error("❌ Network check failed: $e");
      return false;
    }
  }
}
