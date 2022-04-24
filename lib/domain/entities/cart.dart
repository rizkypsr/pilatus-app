import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';

class Cart extends Equatable {
  final int? id;
  final List<DetailsCart> detailsCart;

  const Cart({required this.id, required this.detailsCart});

  @override
  List<Object?> get props => [id, detailsCart];
}
