import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfo {
  Future<bool> get isConnected async {
    final List<ConnectivityResult> result = await Connectivity()
        .checkConnectivity();
    return _handleResult(result);
  }
Future<bool> hasInternetConnection() async {
  return await InternetConnection().hasInternetAccess;
}
  static Stream<List<ConnectivityResult>> listenToConnectivityChanged() {
    return Connectivity().onConnectivityChanged;
  }

  bool _handleResult(List<ConnectivityResult> result) {
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }
}
