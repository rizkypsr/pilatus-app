import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/address_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/entities/province.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<City>>> getCities(int provinceId) async {
    try {
      final result = await remoteDataSource.getCities(provinceId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Province>>> getProvince() async {
    try {
      final result = await remoteDataSource.getProvince();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Address>> getAddress() async {
    try {
      final result = await remoteDataSource.getAddress();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveAddress(Address address) async {
    try {
      final result = await remoteDataSource.saveAddress(address);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
