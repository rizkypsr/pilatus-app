part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderHasData extends OrderState {
  final List<Orders> orders;

  const OrderHasData(this.orders);

  @override
  List<Object> get props => orders;
}

class OrderAdded extends OrderState {
  final int id;

  const OrderAdded(this.id);

  @override
  List<Object> get props => [id];
}

class OrderUpdated extends OrderState {
  final String message;

  const OrderUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class OrderFinished extends OrderState {
  final String message;

  const OrderFinished(this.message);

  @override
  List<Object> get props => [message];
}
