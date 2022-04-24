import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/costs.dart';

abstract class ShippingRepository {
  Future<Either<Failure, List<Costs>>> getCost(
      int origin, int destination, int weight);
}
