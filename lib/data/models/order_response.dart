import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/order_model.dart';

class OrderResponse extends Equatable {
  final List<OrderModel> orders;

  const OrderResponse({required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        orders: List<OrderModel>.from(
            (json["data"] as List).map((x) => OrderModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [orders];
}
