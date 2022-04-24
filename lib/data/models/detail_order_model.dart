import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/product_model.dart';
import 'package:pilatusapp/domain/entities/details_order.dart';

class DetailOrderModel extends Equatable {
  final int id;
  final ProductModel product;
  final int quantity;

  const DetailOrderModel(
      {required this.id, required this.product, required this.quantity});

  factory DetailOrderModel.fromJson(Map<String, dynamic> json) =>
      DetailOrderModel(
          id: json['id'],
          product: ProductModel.fromJson(json['product']),
          quantity: json['quantity']);

  DetailOrder toEntity() {
    return DetailOrder(
      id: id,
      products: product.toEntity(),
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];
}
