import 'package:app_assesment/dependency/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/login/presentation/pages/login_page.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependecy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          routes: {
            '/login': (_) => const LoginPage(),
            '/products': (_) => BlocProvider(
              create: (_) => ProductsBloc(dependency<GetProducts>()),
              child: const ProductPage(),
            ),
          },
          initialRoute: '/login',
        );
      },
    );
  }
}
