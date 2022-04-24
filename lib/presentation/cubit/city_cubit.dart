import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/usecase/get_city.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit({required this.getCity}) : super(CitiesInitial());

  final GetCity getCity;

  void fetchCities(int provinceId) async {
    emit(CitiesLoading());
    final results = await getCity.execute(provinceId);

    results.fold(
        (failure) => emit(CitiesError(failure.message)),
        (cities) => emit(
              CitiesHasData(cities),
            ));
  }

  void citiesOnChanged(String id) {
    emit(CitiesOnChanged(id));
  }
}
