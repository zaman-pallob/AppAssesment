import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsStarted extends ProductsEvent {}

class ProductsRefreshed extends ProductsEvent {}

class ProductsNextPageRequested extends ProductsEvent {}
