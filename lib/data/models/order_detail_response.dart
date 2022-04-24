import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/order_detail_model.dart';

class OrderDetailResponse extends Equatable {
  final OrderDetailModel order;

  const OrderDetailResponse({required this.order});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        order: OrderDetailModel.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [order];
}
