import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/details_order.dart';

class Orders extends Equatable {
  const Orders(
      {required this.id,
      required this.detailsOrder,
      required this.status,
      required this.total,
      required this.createdAt});

  final int id;
  final List<DetailOrder> detailsOrder;
  final String status;
  final int total;
  final String createdAt;

  @override
  List<Object?> get props => [id, detailsOrder, total, createdAt];
}
