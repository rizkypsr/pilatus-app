import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/details_cart_model.dart';
import 'package:pilatusapp/domain/entities/cart.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';

class CartModel extends Equatable {
  const CartModel({required this.id, required this.detailsCart});

  final int? id;
  final List<DetailsCart> detailsCart;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['data'] != null ? json['data']["id"] : null,
        detailsCart: json['data'] != null
            ? List<DetailsCart>.from(json['data']["detail_cart"]
                .map((x) => DetailsCartModel.fromJson(x).toEntity()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail_cart": detailsCart,
      };

  Cart toEntity() {
    return Cart(
      id: id,
      detailsCart: detailsCart,
    );
  }

  @override
  List<Object?> get props => [id, detailsCart];
}
