import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/province.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';

class GetProvince {
  final AddressRepository repository;

  GetProvince(this.repository);

  Future<Either<Failure, List<Province>>> execute() {
    return repository.getProvince();
  }
}
