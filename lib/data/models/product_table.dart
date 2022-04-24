import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product.dart';

class ProductTable extends Equatable {
  const ProductTable(this.id, this.name, this.photo, this.total);

  final int id;
  final String name;
  final String photo;
  final int total;

  factory ProductTable.fromEntity(Product product) =>
      ProductTable(product.id, product.name, product.photo, product.total);

  factory ProductTable.fromMap(Map<String, dynamic> map) => ProductTable(
        map['id'],
        map['name'],
        map['photo'],
        map['total'],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'photo': photo, 'total': total};

  @override
  List<Object?> get props => [id, name, photo, total];
}
