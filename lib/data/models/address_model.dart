import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/city_model.dart';
import 'package:pilatusapp/data/models/province_model.dart';
import 'package:pilatusapp/domain/entities/address.dart';

class AddressModel extends Equatable {
  const AddressModel(
      {required this.id,
      required this.street,
      required this.postalCode,
      required this.province,
      required this.city,
      required this.district});

  final int id;
  final String street;
  final String postalCode;
  final ProvinceModel province;
  final CityModel city;
  final String district;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        province: ProvinceModel.fromJson(json['province']),
        city: CityModel.fromJson(json['city']),
        street: json["street"],
        postalCode: json["postal_code"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "province": province,
        "city": city,
        "postal_code": postalCode,
        "district": district
      };

  Address toEntity() {
    return Address(
      id: id,
      city: city.toEntity(),
      district: district,
      postalCode: postalCode,
      province: province.toEntity(),
      street: street,
    );
  }

  @override
  List<Object?> get props => [id, street, province, city, postalCode, district];
}
