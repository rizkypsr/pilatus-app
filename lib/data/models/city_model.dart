import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/city.dart';

class CityModel extends Equatable {
  const CityModel(
      {required this.cityId,
      required this.type,
      required this.cityName,
      required this.postalCode});

  final int cityId;
  final String type;
  final String cityName;
  final String postalCode;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
      cityId: json["city_id"],
      type: json["type"],
      cityName: json['city_name'],
      postalCode: json['postal_code']);

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };

  City toEntity() {
    return City(
      cityId: cityId,
      cityName: cityName,
      postalCode: postalCode,
      type: type,
    );
  }

  @override
  List<Object?> get props => [cityId, cityName, postalCode, type];
}
