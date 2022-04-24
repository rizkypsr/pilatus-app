part of 'order_detail_cubit.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState {}

class OrderDetailLoading extends OrderDetailState {}

class OrderDetailError extends OrderDetailState {
  final String message;

  const OrderDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderDetailHasData extends OrderDetailState {
  final OrderDetail orderDetail;

  const OrderDetailHasData(this.orderDetail);

  @override
  List<Object> get props => [orderDetail];
}
