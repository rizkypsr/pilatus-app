import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/category.dart';

class CategoryTable extends Equatable {
  const CategoryTable(this.id, this.name);

  final int id;
  final String name;

  factory CategoryTable.fromEntity(Category category) =>
      CategoryTable(category.id, category.name);

  factory CategoryTable.fromMap(Map<String, dynamic> map) => CategoryTable(
        map['id'],
        map['name'],
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  List<Object?> get props => [id, name];
}
