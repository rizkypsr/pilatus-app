import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/province.dart';
import 'package:pilatusapp/domain/usecase/get_province.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceCubit({required this.getProvince}) : super(ProvinceInitial());

  final GetProvince getProvince;

  void fetchProvince() async {
    emit(ProvinceLoading());
    final results = await getProvince.execute();

    results.fold(
        (failure) => emit(ProvinceError(failure.message)),
        (province) => emit(
              ProvinceHasData(province),
            ));
  }

  void provinceOnChanged(String id) {
    emit(ProvinceOnChanged(id));
  }
}
