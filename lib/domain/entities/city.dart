import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int cityId;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const City({required this.cityId, this.type, this.cityName, this.postalCode});

  @override
  List<Object?> get props => [cityId, type, cityName, postalCode];
}
