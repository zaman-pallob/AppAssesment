import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:hive/hive.dart';

import '../models/product_model.dart';

abstract class LocalDataSource {
  Future<void> storeProducts(List<ProductModel> products);
  Future<List<ProductModel>> getProducts();
}

class LocalDataSourceImp extends LocalDataSource {
  Box box;
  LocalDataSourceImp(this.box);

  @override
  Future<List<ProductModel>> getProducts() async {
    var data = box.get(AppConstant.products, defaultValue: null);

    if (data != null) {
      var list = (data as List)
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      return list;
    }
    return [];
  }

  @override
  Future<void> storeProducts(List<ProductModel> products) async {
    var productsMapList = products.map((e) => e.toJson()).toList();
    await box.put(AppConstant.products, productsMapList);
  }
}
