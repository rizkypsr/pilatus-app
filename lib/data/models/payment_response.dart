import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/payment_model.dart';

class PaymentResponse extends Equatable {
  final PaymentModel? payment;

  const PaymentResponse({this.payment});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(payment: PaymentModel.fromJson(json['data']));

  @override
  List<Object?> get props => [payment];
}
