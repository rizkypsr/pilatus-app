part of 'city_cubit.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CitiesInitial extends CityState {}

class CitiesLoading extends CityState {}

class CitiesOnChanged extends CityState {
  final String id;

  const CitiesOnChanged(this.id);

  @override
  List<Object> get props => [id];
}

class CitiesError extends CityState {
  final String message;

  const CitiesError(this.message);

  @override
  List<Object> get props => [message];
}

class CitiesHasData extends CityState {
  final List<City> cities;

  const CitiesHasData(this.cities);

  @override
  List<Object> get props => [cities];
}
