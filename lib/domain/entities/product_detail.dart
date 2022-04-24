import 'package:equatable/equatable.dart';

import 'category.dart';

class ProductDetail extends Equatable {
  const ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.stock,
    required this.weight,
    required this.total,
  });

  final int id;
  final String description;
  final String name;
  final String photo;
  final int stock;
  final double weight;
  final int total;

  @override
  List<Object?> get props => [id, name, photo, stock, weight, total];
}
