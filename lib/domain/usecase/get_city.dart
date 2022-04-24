import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';

class GetCity {
  final AddressRepository repository;

  GetCity(this.repository);

  Future<Either<Failure, List<City>>> execute(int provinceId) {
    return repository.getCities(provinceId);
  }
}
