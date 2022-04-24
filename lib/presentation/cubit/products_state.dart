part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductsHasData extends ProductsState {
  final List<Product> results;

  const ProductsHasData(this.results);

  @override
  List<Object> get props => [results];
}

class ProductsCubitInitial extends ProductsState {}
