import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/category.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Category toEntity() {
    return Category(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
