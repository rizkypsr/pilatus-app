import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/address_model.dart';
import 'package:pilatusapp/domain/entities/shipping.dart';

class ShippingModel extends Equatable {
  const ShippingModel(
      {required this.id,
      required this.address,
      required this.courier,
      required this.shippingCost,
      required this.service,
      this.resi});

  final int id;
  final AddressModel address;
  final String courier;
  final int shippingCost;
  final String service;
  final String? resi;

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        id: json["id"],
        address: AddressModel.fromJson(json['address']),
        courier: json["courier"],
        service: json["service"],
        resi: json["resi"],
        shippingCost: json["shipping_cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courier": courier,
        "shipping_cost": shippingCost,
        "service": service,
        "resi": resi
      };

  Shipping toEntity() {
    return Shipping(
      id: id,
      address: address.toEntity(),
      courier: courier,
      service: service,
      shippingCost: shippingCost,
      resi: resi,
    );
  }

  @override
  List<Object?> get props => [id, address, courier, service, shippingCost];
}
