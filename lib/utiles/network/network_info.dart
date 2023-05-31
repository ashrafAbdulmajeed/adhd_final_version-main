import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  // Future<bool> get isConnected => connectionChecker.hasConnection;

  Future<bool> get isConnected => checkInternetConnection();

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      // return true;
    } on SocketException catch (_) {
      // return true;
      return false;
    }
    return false;
    // return true;
  }
  // Future<bool> checkInternetConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return true;
  //     }
  //
  //   } on SocketException catch (_) {
  //     return true;
  //     return false;
  //   }
  //   // return false;
  //   return true;
  // }
}
