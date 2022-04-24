import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/details_order.dart';
import 'package:pilatusapp/domain/entities/payment.dart';
import 'package:pilatusapp/domain/entities/shipping.dart';

class OrderDetail extends Equatable {
  final int id;
  final String status;
  final List<DetailOrder> detailOrders;
  final Shipping? shipping;
  final Payment? payment;
  final int total;
  final String createdAt;

  const OrderDetail(
      {required this.id,
      required this.shipping,
      required this.detailOrders,
      required this.status,
      required this.payment,
      required this.total,
      required this.createdAt});

  @override
  List<Object?> get props =>
      [id, shipping, payment, detailOrders, status, total, createdAt];
}
