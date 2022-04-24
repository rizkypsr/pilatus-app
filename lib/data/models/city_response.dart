import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/city_model.dart';

class CityResponse extends Equatable {
  final List<CityModel> cities;

  const CityResponse({required this.cities});

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        cities: List<CityModel>.from(
            (json["data"] as List).map((x) => CityModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [cities];
}
