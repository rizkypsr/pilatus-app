import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';

class ProductDetailResponse extends Equatable {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String photo;
  final int stock;
  final int weight;
  final int total;

  const ProductDetailResponse(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.description,
      required this.photo,
      required this.stock,
      required this.weight,
      required this.total});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        id: json["data"]["id"],
        categoryId: json["data"]["category_id"],
        name: json["data"]["name"],
        description: json["data"]["description"],
        photo: json["data"]["photo"],
        stock: json["data"]["stock"],
        weight: json["data"]["weight"],
        total: json["data"]["total"],
      );

  ProductDetail toEntity() {
    return ProductDetail(
      id: id,
      name: name,
      description: description,
      photo: photo,
      stock: stock,
      weight: weight.toDouble(),
      total: total,
    );
  }

  @override
  List<Object?> get props =>
      [id, categoryId, name, description, photo, stock, weight, total];
}
