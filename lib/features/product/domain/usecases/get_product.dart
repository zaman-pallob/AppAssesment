import '../entities/product.dart';
import '../repositories/product_repositories.dart';

class GetProducts {
  final ProductRepositories repository;
  GetProducts(this.repository);

  Future<List<Product>> call(int limit, int skip) async {
    return await repository.getProducts(limit: limit, skip: skip);
  }
}
