import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final int provinceId;
  final String? province;

  const Province({required this.provinceId, this.province});

  @override
  List<Object?> get props => [provinceId, province];
}
