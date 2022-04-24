import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/costs.dart';
import 'package:pilatusapp/domain/repositories/shipping_repository.dart';

class GetCost {
  final ShippingRepository repository;

  GetCost(this.repository);

  Future<Either<Failure, List<Costs>>> execute(
      int origin, int destination, int weight) {
    return repository.getCost(origin, destination, weight);
  }
}
