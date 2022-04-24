part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

class CartHasData extends CartState {
  final List<DetailsCart> results;

  const CartHasData(this.results);

  @override
  List<Object> get props => [results];
}

class CartAdded extends CartState {
  final String message;

  const CartAdded(this.message);

  @override
  List<Object> get props => [message];
}

class CartRemoved extends CartState {
  final String message;

  const CartRemoved(this.message);

  @override
  List<Object> get props => [message];
}
