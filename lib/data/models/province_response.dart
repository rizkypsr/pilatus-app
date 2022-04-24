import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/province_model.dart';

class ProvinceResponse extends Equatable {
  final List<ProvinceModel> province;

  const ProvinceResponse({required this.province});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        province: List<ProvinceModel>.from(
            (json["data"] as List).map((x) => ProvinceModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [province];
}
