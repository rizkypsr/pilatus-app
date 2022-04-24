import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product.dart';

class DetailsCart extends Equatable {
  final int id;
  final Product product;
  final int quantity;

  const DetailsCart(
      {required this.id, required this.product, required this.quantity});

  @override
  List<Object?> get props => [id, product, quantity];
}
