import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/product_model.dart';

class ProductResponse extends Equatable {
  final List<ProductModel> products;

  const ProductResponse({required this.products});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        products: List<ProductModel>.from(
            (json["data"] as List).map((x) => ProductModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [products];
}
