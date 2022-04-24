import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product.dart';

class DetailOrder extends Equatable {
  const DetailOrder({
    required this.id,
    required this.products,
    required this.quantity,
  });

  final int id;
  final Product products;
  final int quantity;

  @override
  List<Object?> get props => [id, products, quantity];
}
