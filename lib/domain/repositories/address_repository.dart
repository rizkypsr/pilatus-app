import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/entities/province.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<Province>>> getProvince();
  Future<Either<Failure, List<City>>> getCities(int provinceId);
  Future<Either<Failure, Address>> getAddress();
  Future<Either<Failure, String>> saveAddress(Address address);
}
