import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/category_model.dart';

class CategoryResponse extends Equatable {
  final List<CategoryModel> categories;

  const CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        categories: List<CategoryModel>.from(
            (json["data"] as List).map((x) => CategoryModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [categories];
}
