part of 'province_cubit.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceOnChanged extends ProvinceState {
  final String id;

  const ProvinceOnChanged(this.id);

  @override
  List<Object> get props => [id];
}

class ProvinceError extends ProvinceState {
  final String message;

  const ProvinceError(this.message);

  @override
  List<Object> get props => [message];
}

class ProvinceHasData extends ProvinceState {
  final List<Province> province;

  const ProvinceHasData(this.province);

  @override
  List<Object> get props => [province];
}
