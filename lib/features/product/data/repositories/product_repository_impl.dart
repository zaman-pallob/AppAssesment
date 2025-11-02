import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:app_assesment/core/errors/failures.dart';
import 'package:app_assesment/core/networks/network_info.dart';
import 'package:app_assesment/features/product/data/datasources/product_local.dart';
import 'package:app_assesment/features/product/data/datasources/product_remote.dart';
import 'package:app_assesment/features/product/domain/entities/products_info.dart';
import 'package:app_assesment/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl extends ProductRepository {
  LocalDataSource local;
  RemoteDataSource remote;
  NetworkInfo networkInfo;
  ProductRepositoryImpl(this.local, this.remote, this.networkInfo);

  @override
  Future<Either<Failure, ProductsInfo>> getProducts({
    required int skip,
    required int limit,
    bool forceRefresh = false,
  }) async {
    final connected = await networkInfo.isConnected;

    final last = await local.lastSyncTime();
    final isRequiredToFetch =
        last == null ||
        DateTime.now().difference(last) > AppConstant.syncDuration;

    if (!connected) {
      // when the apps is offline, we will use local storage
      var (storedProductList, hasMore) = await local.getLocalProducts(
        skip,
        limit,
      );
      return Right(
        ProductsInfo(
          productList: storedProductList,
          hasMore: hasMore,
          fromStorage: true,
        ),
      );
    } else {
      if (!forceRefresh && !isRequiredToFetch && skip == 0) {
        // we are using storage for initial load when not force refresh and within sync duration and online
        final (storedProductList, hasMore) = await local.getLocalProducts(
          skip,
          limit,
        );
        if (storedProductList.isNotEmpty) {
          return Right(
            ProductsInfo(
              productList: storedProductList,
              hasMore: hasMore,
              fromStorage: true,
            ),
          );
        }
      }

      try {
        var (remoteProducts, hasMore) = await remote.getProductsFromAPI(
          skip: skip,
          limit: limit,
        );
        await local.storeProducts(remoteProducts, skip);
        await local.setLastSyncTime(DateTime.now());

        return Right(
          ProductsInfo(
            productList: remoteProducts,
            hasMore: hasMore,
            fromStorage: false,
          ),
        );
      } on Exception catch (e, _) {
        return Left(Failure(e.toString()));
      }
    }
  }
}
