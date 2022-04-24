import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/costs.dart';
import 'package:pilatusapp/domain/usecase/get_cost.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit({required this.getCost}) : super(ShippingInitial());

  final GetCost getCost;

  void costOnChanged(String newValue) {
    emit(ShippingOnChanged(newValue));
  }

  void fetchCost(int origin, int destination, int weight) async {
    emit(ShippingLoading());

    final results = await getCost.execute(origin, destination, weight);

    results.fold(
        (l) => emit(ShippingError(l.message)), (r) => emit(ShippingHasData(r)));
  }
}
