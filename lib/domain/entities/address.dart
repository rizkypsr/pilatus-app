import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/entities/province.dart';

class Address extends Equatable {
  final int? id;
  final String street;
  final Province province;
  final City city;
  final String postalCode;
  final String district;

  const Address(
      {this.id,
      required this.street,
      required this.province,
      required this.city,
      required this.postalCode,
      required this.district});

  @override
  List<Object?> get props => [id, street, province, city, postalCode, district];
}
