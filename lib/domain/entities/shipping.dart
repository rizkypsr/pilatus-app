import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/address.dart';

class Shipping extends Equatable {
  final int id;
  final Address address;
  final String courier;
  final int shippingCost;
  final String service;
  final String? resi;

  const Shipping(
      {required this.id,
      required this.address,
      required this.courier,
      required this.shippingCost,
      required this.service,
      this.resi});

  @override
  List<Object?> get props =>
      [id, address, service, courier, shippingCost, service, resi];
}
