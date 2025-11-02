import 'package:app_assesment/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class RemoteDataSource {
  Dio dio;
  RemoteDataSource(this.dio);

  Future<List<ProductModel>> getProductsFromAPI(int limit, int skip) async {
    var res = await dio.get(
      '/products',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    if (res.statusCode == 200) {
      List<ProductModel> products = (res.data['products'] as List)
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return products;
    } else {
      throw Exceptions.getExceptions(res);
    }
  }
}
