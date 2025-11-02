import 'package:app_assesment/core/networks/client.dart';
import 'package:app_assesment/core/networks/network_info.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/product/data/models/product_model.dart';

GetIt dependency = GetIt.instance;
Future injectDependecy() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Box box = await Hive.openBox("productsBox");

  dependency.registerLazySingleton<Box>(() => box);
  dependency.registerLazySingleton<Dio>(() => Client.createClient());
  dependency.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl());
}
