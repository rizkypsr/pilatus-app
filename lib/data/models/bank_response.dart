import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/bank_model.dart';

class BankResponse extends Equatable {
  final BankModel bank;

  const BankResponse({required this.bank});

  factory BankResponse.fromJson(Map<String, dynamic> json) => BankResponse(
        bank: BankModel.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [bank];
}
