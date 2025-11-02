import 'package:app_assesment/core/networks/client.dart';
import 'package:app_assesment/core/networks/network_info.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt dependency = GetIt.instance;
Future injectDependecy() async {
  dependency.registerLazySingleton<Dio>(() => Client.createClient());
  dependency.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl());
}
