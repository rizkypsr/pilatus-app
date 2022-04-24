import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';

class SaveAdress {
  final AddressRepository repository;

  SaveAdress(this.repository);

  Future<Either<Failure, String>> execute(Address address) {
    return repository.saveAddress(address);
  }
}
