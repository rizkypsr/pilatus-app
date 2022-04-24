import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/address_model.dart';

class AddressResponse extends Equatable {
  final AddressModel address;

  const AddressResponse({required this.address});

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        address: AddressModel.fromJson(json['data']),
      );

  @override
  List<Object?> get props => [address];
}
