import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/category_model.dart';
import 'package:pilatusapp/data/models/costs_model.dart';

class CostsResponse extends Equatable {
  final List<CostsModel> costs;

  const CostsResponse({required this.costs});

  factory CostsResponse.fromJson(Map<String, dynamic> json) => CostsResponse(
        costs: List<CostsModel>.from(
            (json["rajaongkir"]["results"][0]["costs"] as List)
                .map((x) => CostsModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [costs];
}
