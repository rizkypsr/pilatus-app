import 'package:equatable/equatable.dart';

class Cost extends Equatable {
  final int value;
  final String etd;

  const Cost({required this.value, required this.etd});

  @override
  List<Object?> get props => [value, etd];
}
