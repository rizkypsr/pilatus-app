import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';
import 'package:pilatusapp/domain/usecase/get_order_detail.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit({required this.getOrderDetail})
      : super(OrderDetailInitial());

  final GetOrderDetail getOrderDetail;

  void fetchOrderDetail(int id) async {
    emit(OrderDetailLoading());

    final results = await getOrderDetail.execute(id);

    results.fold(
      (failure) {
        emit(OrderDetailError(failure.message));
      },
      (order) {
        emit(OrderDetailHasData(order));
      },
    );
  }
}
