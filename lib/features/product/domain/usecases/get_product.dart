import 'package:app_assesment/core/errors/failures.dart';
import 'package:app_assesment/features/product/domain/entities/products_info.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<Either<Failure, ProductsInfo>> call({
    required int limit,
    required int skip,
    bool forceRefresh = false,
  }) async {
    return await repository.getProducts(
      limit: limit,
      skip: skip,
      forceRefresh: forceRefresh,
    );
  }
}
