import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/cost_model.dart';
import 'package:pilatusapp/domain/entities/costs.dart';

class CostsModel extends Equatable {
  const CostsModel({required this.service, required this.cost});

  final String service;
  final List<CostModel> cost;

  factory CostsModel.fromJson(Map<String, dynamic> json) => CostsModel(
        service: json["service"],
        cost: List<CostModel>.from(
            json["cost"].map((x) => CostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"service": service, "cost": cost};

  Costs toEntity() {
    return Costs(
      costs: cost.map((x) => x.toEntity()).toList(),
      service: service,
    );
  }

  @override
  List<Object?> get props => [service, cost];
}
