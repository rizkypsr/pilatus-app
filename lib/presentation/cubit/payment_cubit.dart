import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/payment.dart';
import 'package:pilatusapp/domain/usecase/get_payment.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.getPayment}) : super(PaymentInitial());

  final GetPayment getPayment;

  void fetchPayment(int id) async {
    emit(PaymentLoading());

    final result = await getPayment.execute(id);

    result.fold(
        (l) => emit(PaymentError(l.message)), (r) => emit(PaymentHasData(r)));
  }
}
