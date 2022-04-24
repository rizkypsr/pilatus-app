import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';

class GetAddress {
  final AddressRepository repository;

  GetAddress(this.repository);

  Future<Either<Failure, Address>> execute() {
    return repository.getAddress();
  }
}
