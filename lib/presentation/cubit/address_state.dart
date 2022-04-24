part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object> get props => [message];
}

class AddressSaved extends AddressState {
  final String message;

  const AddressSaved(this.message);

  @override
  List<Object> get props => [message];
}

class AddressHasData extends AddressState {
  final Address address;

  const AddressHasData(this.address);

  @override
  List<Object> get props => [address];
}
