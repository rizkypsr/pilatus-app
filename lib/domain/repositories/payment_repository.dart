import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/bank.dart';

abstract class PaymentRepository {
  Future<Either<Failure, Bank>> getBank();
}
