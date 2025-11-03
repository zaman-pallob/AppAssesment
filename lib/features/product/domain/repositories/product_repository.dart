import 'package:app_assesment/features/product/domain/entities/products_info.dart';

import '../../../../core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsInfo>> getProducts({
    required int skip,
    required int limit,
    bool forceRefresh = false,
  });
}
