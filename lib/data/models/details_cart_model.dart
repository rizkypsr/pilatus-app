import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/product_model.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';

class DetailsCartModel extends Equatable {
  final int id;
  final ProductModel product;
  final int quantity;

  const DetailsCartModel(
      {required this.id, required this.product, required this.quantity});

  factory DetailsCartModel.fromJson(Map<String, dynamic> json) =>
      DetailsCartModel(
          id: json['id'],
          product: ProductModel.fromJson(json['product']),
          quantity: json['quantity']);

  DetailsCart toEntity() {
    return DetailsCart(
      id: id,
      product: product.toEntity(),
      quantity: quantity,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];
}
