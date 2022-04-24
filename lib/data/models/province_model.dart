import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/province.dart';

class ProvinceModel extends Equatable {
  const ProvinceModel({required this.provinceId, required this.province});

  final int provinceId;
  final String province;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
      provinceId: json["province_id"], province: json["province"]);

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };

  Province toEntity() {
    return Province(
      provinceId: provinceId,
      province: province,
    );
  }

  @override
  List<Object?> get props => [provinceId, province];
}
