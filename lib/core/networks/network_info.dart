import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get hasInternet;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();

    if (results.contains(ConnectivityResult.none)) {
      return false;
    } else {
      //the mobile device might be connected with wifi or any other networking device but we need to check either it is able to connect to the internet so need to address lookup
      return await hasInternet;
    }
  }

  @override
  Future<bool> get hasInternet async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
