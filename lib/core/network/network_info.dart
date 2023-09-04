import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show debugPrint;

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final connectionResult = await connectivity.checkConnectivity();
      if (connectionResult == ConnectivityResult.mobile ||
          connectionResult == ConnectivityResult.wifi) {
        return Future.value(true);
      }
      debugPrint("Network checking: And we have no internet.");
      return Future.value(false);
    } on SocketException catch (_) {
      return Future.value(false);
    } catch (e) {
      debugPrint("isConnected: $e");
      return Future.value(false);
    }
  }
}
