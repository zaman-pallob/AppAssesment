import 'package:app_assesment/features/product/data/models/product_model.dart';

class ProductsInfo {
  List<ProductModel> productList;
  final bool hasMore;
  final bool fromStorage;
  ProductsInfo({
    required this.productList,
    required this.hasMore,
    required this.fromStorage,
  });
}
