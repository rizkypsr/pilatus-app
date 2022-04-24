import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.stock,
    required this.weight,
    required this.total,
  });

  final int id;
  final String name;
  final String description;
  final String photo;
  final int stock;
  final int weight;
  final int total;

  @override
  List<Object?> get props =>
      [id, name, description, photo, stock, weight, total];
}
