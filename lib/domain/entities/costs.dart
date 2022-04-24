import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/cost.dart';

class Costs extends Equatable {
  final String service;
  final List<Cost> costs;

  const Costs({required this.costs, required this.service});

  @override
  List<Object?> get props => [costs];
}
