import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {}

class ProductsEmpty extends ProductsState {}

class RedirectToLogin extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final bool hasMore;
  final bool isOnline;
  final bool isLoadingMore;
  ProductsLoaded(
    this.products,
    this.hasMore,
    this.isOnline,
    this.isLoadingMore,
  );
  @override
  List<Object?> get props => [products, hasMore, isOnline, isLoadingMore];

  ProductsLoaded copyWith({
    List<ProductModel>? products,
    bool? hasMore,
    bool? isOnline,
    bool? isLoadingMore,
  }) {
    return ProductsLoaded(
      products ?? this.products,
      hasMore ?? this.hasMore,
      isOnline ?? this.isOnline,
      isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
