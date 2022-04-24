import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/detail_order_model.dart';
import 'package:pilatusapp/data/models/payment_model.dart';
import 'package:pilatusapp/data/models/shipping_model.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';

class OrderDetailModel extends Equatable {
  const OrderDetailModel(
      {required this.id,
      required this.detailOrder,
      required this.status,
      required this.total,
      this.payment,
      this.shipping,
      required this.createdAt});

  final int id;
  final List<DetailOrderModel> detailOrder;
  final String status;
  final int total;
  final PaymentModel? payment;
  final ShippingModel? shipping;
  final String createdAt;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        id: json["id"],
        detailOrder: List<DetailOrderModel>.from(
            json["detail_order"].map((x) => DetailOrderModel.fromJson(x))),
        status: json['status'],
        total: json['total'],
        createdAt: json['created_at'],
        payment: json['payment'] != null
            ? PaymentModel.fromJson(json['payment'])
            : null,
        shipping: json['shipping'] != null
            ? ShippingModel.fromJson(json['shipping'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail_cart": detailOrder,
        "status": status,
        "total": total,
        "shipping": shipping,
        "payment": payment,
        "created_at": createdAt
      };

  OrderDetail toEntity() {
    return OrderDetail(
        id: id,
        detailOrders: detailOrder.map((x) => x.toEntity()).toList(),
        status: status,
        shipping: shipping != null ? shipping!.toEntity() : null,
        payment: payment != null ? payment!.toEntity() : null,
        createdAt: createdAt,
        total: total);
  }

  @override
  List<Object?> get props =>
      [id, detailOrder, status, total, createdAt, shipping, payment];
}
