part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

class BankInitial extends BankState {}

class BankHasData extends BankState {
  final Bank bank;

  const BankHasData(this.bank);

  @override
  List<Object> get props => [bank];
}
