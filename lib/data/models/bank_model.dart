import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/bank.dart';

class BankModel extends Equatable {
  const BankModel(
      {required this.id,
      required this.owner,
      required this.bank,
      required this.branch});

  final int id;
  final String owner;
  final String bank;
  final String branch;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
      id: json["id"],
      owner: json['owner'],
      bank: json['bank'],
      branch: json['branch']);

  Map<String, dynamic> toJson() =>
      {"id": id, "owner": owner, "bank": bank, "branch": branch};

  Bank toEntity() {
    return Bank(id: id, owner: owner, bank: bank, branch: branch);
  }

  @override
  List<Object?> get props => [id, owner, branch, bank];
}
