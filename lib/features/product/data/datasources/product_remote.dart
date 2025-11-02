import 'package:app_assesment/core/errors/appexceptions.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class RemoteDataSource {
  Dio dio;
  RemoteDataSource(this.dio);

  Future<(List<ProductModel>, bool)> getProductsFromAPI({
    required int limit,
    required int skip,
  }) async {
    var res = await dio.get(
      '/products',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    if (res.statusCode == 200) {
      List<ProductModel> products = (res.data['products'] as List)
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      int total = res.data['total'] as int? ?? 0;
      bool hasMore = total > (skip + products.length);

      return (products, hasMore);
    } else {
      throw AppExceptions.getExceptions(res);
    }
  }
}
