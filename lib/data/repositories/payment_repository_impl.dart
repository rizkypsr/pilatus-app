import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/bank_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/bank.dart';
import 'package:pilatusapp/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final BankRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Bank>> getBank() async {
    try {
      final result = await remoteDataSource.getBank();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
