import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/order.dart';
import 'package:pilatusapp/domain/usecase/add_order.dart';
import 'package:pilatusapp/domain/usecase/finish_order.dart';
import 'package:pilatusapp/domain/usecase/get_orders.dart';
import 'package:pilatusapp/domain/usecase/update_payment.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(
      {required this.getOrders,
      required this.addOrder,
      required this.updatePayment,
      required this.finishOrder})
      : super(OrderInitial());

  final GetOrders getOrders;
  final AddOrder addOrder;
  final UpdatePayment updatePayment;
  final FinishOrder finishOrder;

  void fetchOrders(String status) async {
    emit(OrderLoading());

    final results = await getOrders.execute(status);

    results.fold((failure) async {
      emit(OrderError(failure.message));
    }, (data) {
      emit(OrderHasData(data));
    });
  }

  void saveOrder(Map<String, dynamic> order) async {
    final results = await addOrder.execute(order);

    results.fold((failure) async {
      emit(OrderError(failure.message));
    }, (data) {
      emit(OrderAdded(data));
    });
  }

  void updatePaymentOrder(File image, int id) async {
    emit(OrderLoading());
    final results = await updatePayment.execute(image, id);

    results.fold((failure) async {
      emit(OrderError(failure.message));
    }, (data) {
      emit(OrderUpdated(data));
    });
  }

  void finishTheOrder(int id) async {
    emit(OrderLoading());
    final results = await finishOrder.execute(id);

    results.fold((failure) async {
      emit(OrderError(failure.message));
    }, (data) {
      emit(OrderFinished(data));
    });
  }
}
