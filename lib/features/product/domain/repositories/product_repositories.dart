import '../entities/product.dart';

abstract class ProductRepositories {
  Future<List<Product>> getProducts({required int limit, required int skip});
}
