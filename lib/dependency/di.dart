import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:app_assesment/core/networks/client.dart';
import 'package:app_assesment/core/networks/network_info.dart';
import 'package:app_assesment/features/product/data/datasources/product_remote.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/product/data/datasources/product_local.dart';

GetIt dependency = GetIt.instance;
Future injectDependecy() async {
  await Hive.initFlutter();

  Box trackerBox = await Hive.openBox(AppConstant.tracker);
  Box productListBox = await Hive.openBox(AppConstant.productList);
  dependency.registerLazySingleton<Dio>(() => Client.createClient());
  dependency.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl());

  dependency.registerLazySingleton<LocalDataSource>(
    () => LocalDataSource(trackerBox, productListBox),
  );
  dependency.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(dependency<Dio>()),
  );
}
