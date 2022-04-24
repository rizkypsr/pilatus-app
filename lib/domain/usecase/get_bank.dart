import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/bank.dart';
import 'package:pilatusapp/domain/repositories/payment_repository.dart';

class GetBank {
  final PaymentRepository repository;

  GetBank(this.repository);

  Future<Either<Failure, Bank>> execute() {
    return repository.getBank();
  }
}
