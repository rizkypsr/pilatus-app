import 'package:equatable/equatable.dart';

class Bank extends Equatable {
  const Bank(
      {required this.id,
      required this.owner,
      required this.bank,
      required this.branch});

  final int id;
  final String owner;
  final String bank;
  final String branch;

  @override
  List<Object?> get props => [id, owner, bank, branch];
}
