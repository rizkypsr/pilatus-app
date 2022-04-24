import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/cost.dart';

class CostModel extends Equatable {
  const CostModel({
    required this.value,
    required this.etd,
  });

  final int value;
  final String etd;

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        value: json["value"],
        etd: json["etd"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
      };

  Cost toEntity() {
    return Cost(value: value, etd: etd);
  }

  @override
  List<Object?> get props => [value, etd];
}
