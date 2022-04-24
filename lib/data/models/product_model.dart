import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.photo,
    required this.stock,
    required this.weight,
    required this.total,
  });

  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String photo;
  final int stock;
  final int weight;
  final int total;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
        stock: json["stock"],
        weight: json["weight"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "description": description,
        "photo": photo,
        "stock": stock,
        "weight": weight,
        "total": total,
      };

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      photo: photo,
      stock: stock,
      weight: weight,
      total: total,
    );
  }

  @override
  List<Object?> get props =>
      [id, categoryId, name, description, photo, stock, weight, total];
}
