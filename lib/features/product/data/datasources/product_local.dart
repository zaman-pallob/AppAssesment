import 'dart:convert';

import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:hive/hive.dart';

import '../models/product_model.dart';

class LocalDataSource {
  Box trackerBox, productListBox;
  LocalDataSource(this.trackerBox, this.productListBox);

  Future<void> storeProducts(List<ProductModel> products, int skip) async {
    var page = "page_$skip";
    await productListBox.put(
      page,
      jsonEncode(products.map((e) => e.toJson()).toList()),
    );
  }

  Future<(List<ProductModel>, bool)> getLocalProducts(
    int skip,
    int limit,
  ) async {
    var page = "page_$skip";
    var data = productListBox.get(page, defaultValue: null);
    List keyList = productListBox.keys.toList();
    if (data != null) {
      List<dynamic> jsonList = jsonDecode(data);
      List<ProductModel> products = jsonList
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return (products, keyList.contains("page_${skip + limit}"));
    }

    return (<ProductModel>[], false);
  }

  Future<DateTime?> lastSyncTime() async {
    return trackerBox.get(AppConstant.lastSync) as DateTime?;
  }

  Future<void> setLastSyncTime(DateTime dt) async {
    await trackerBox.put(AppConstant.lastSync, dt);
  }
}
