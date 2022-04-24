import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/detail_order_model.dart';
import 'package:pilatusapp/domain/entities/order.dart';

class OrderModel extends Equatable {
  const OrderModel(
      {required this.id,
      required this.detailOrder,
      required this.status,
      required this.total,
      required this.createdAt});

  final int id;
  final List<DetailOrderModel> detailOrder;
  final String status;
  final int total;
  final String createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        detailOrder: List<DetailOrderModel>.from(
            json["detail_order"].map((x) => DetailOrderModel.fromJson(x))),
        status: json['status'],
        total: json['total'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail_cart": detailOrder,
        "stauts": status,
        "total": total,
        "created_at": createdAt
      };

  Orders toEntity() {
    return Orders(
      id: id,
      detailsOrder: detailOrder.map((x) => x.toEntity()).toList(),
      status: status,
      total: total,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, detailOrder, status, total, createdAt];
}
