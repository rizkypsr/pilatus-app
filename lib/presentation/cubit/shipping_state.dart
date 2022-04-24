part of 'shipping_cubit.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingError extends ShippingState {
  final String message;

  const ShippingError(this.message);

  @override
  List<Object> get props => [message];
}

class ShippingHasData extends ShippingState {
  final List<Costs> costs;

  const ShippingHasData(this.costs);

  @override
  List<Object> get props => [costs];
}

class ShippingOnChanged extends ShippingState {
  final String selectedValue;

  const ShippingOnChanged(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}
