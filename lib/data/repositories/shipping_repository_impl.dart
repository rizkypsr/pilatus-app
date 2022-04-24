import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/shipping_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/costs.dart';
import 'package:pilatusapp/domain/repositories/shipping_repository.dart';

class ShippingRepositoryImpl implements ShippingRepository {
  final ShippingRemoteDataSource remoteDataSource;

  ShippingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Costs>>> getCost(
      int origin, int destination, int weight) async {
    try {
      final result =
          await remoteDataSource.getCost(origin, destination, weight);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
