import 'package:app_assesment/core/constants/app_constant.dart';
import 'package:app_assesment/core/errors/failures.dart';
import 'package:app_assesment/core/utils/logger.dart';
import 'package:app_assesment/features/product/data/models/product_model.dart';
import 'package:app_assesment/features/product/domain/entities/products_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  GetProducts getProducts;
  int skip = 0;
  bool isEnd = false, isLoadingMore = false;
  ProductsBloc(this.getProducts) : super(ProductsLoading()) {
    on<ProductInitial>(_onFetch);
    on<ProductsRefreshed>(_onRefresh);
    on<ProductsNextPage>(_onFetchNext);
  }

  Future<void> _onFetch(
    ProductInitial event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    skip = 0;

    var object = await getProducts.call(
      limit: AppConstant.pageLimit,
      skip: skip,
    );
    object.fold(
      (failure) => handleFailure(failure, emit),
      (productsInfo) => handleDataLoading(productsInfo, emit, false, state),
    );
  }

  Future<void> _onRefresh(
    ProductsRefreshed event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    skip = 0;
    isEnd = false;
    final object = await getProducts.call(
      skip: skip,
      limit: AppConstant.pageLimit,
      forceRefresh: true,
    );
    object.fold(
      (failure) => handleFailure(failure, emit),
      (productsInfo) => handleDataLoading(productsInfo, emit, false, state),
    );
  }

  Future<void> _onFetchNext(
    ProductsNextPage event,
    Emitter<ProductsState> emit,
  ) async {
    if (state is ProductsLoaded && !isEnd && !isLoadingMore) {
      isLoadingMore = true;
      ProductsLoaded currentState = state as ProductsLoaded;
      emit(currentState.copyWith(isLoadingMore: isLoadingMore));
      final objects = await getProducts.call(
        skip: skip,
        limit: AppConstant.pageLimit,
      );
      isLoadingMore = false;
      objects.fold(
        (failure) => handleFailure(failure, emit),
        (productsInfo) =>
            handleDataLoading(productsInfo, emit, true, currentState),
      );
    }
  }

  handleDataLoading(
    ProductsInfo productsInfo,
    Emitter<ProductsState> emit,
    bool isNexPage,
    ProductsState currentState,
  ) {
    if (productsInfo.hasMore) {
      skip += productsInfo.productList.length;
    } else {
      isEnd = true;
    }
    List<ProductModel> products = [];
    if (isNexPage) {
      //when we are laoding next page data
      currentState = currentState as ProductsLoaded;
      products = List.of(currentState.products)
        ..addAll(productsInfo.productList);
    } else {
      products = productsInfo.productList;
    }

    emit(
      ProductsLoaded(
        products,
        productsInfo.hasMore,
        productsInfo.isOnline,
        false,
      ),
    );
  }

  handleFailure(Failure failure, Emitter<ProductsState> emit) {
    if (failure.message.contains("401")) {
      //redirect to login here
      logger.d("Redirect to login");
      emit(RedirectToLogin());
    } else {
      emit(ProductsError(failure.message));
    }
  }
}
