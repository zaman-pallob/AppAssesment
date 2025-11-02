import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {}

class ProductsEmpty extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;
  final bool hasMore;
  final bool fromStorage;
  ProductsSuccess(this.products, this.hasMore, this.fromStorage);
  @override
  List<Object?> get props => [products, hasMore, fromStorage];
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
