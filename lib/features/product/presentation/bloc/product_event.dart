import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductsEvent {}

class ProductsRefreshed extends ProductsEvent {}

class ProductsNextPage extends ProductsEvent {}
