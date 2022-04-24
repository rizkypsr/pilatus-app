import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/order_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/order.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';
import 'package:pilatusapp/domain/entities/payment.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Orders>>> getOrders(String status) async {
    try {
      final results = await remoteDataSource.getOrders(status);
      return Right(results.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, OrderDetail>> getOrderDetail(int id) async {
    try {
      final results = await remoteDataSource.getOrderDetail(id);
      return Right(results.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, int>> addOrder(Map<String, dynamic> order) async {
    try {
      final results = await remoteDataSource.addOrder(order);
      return Right(results);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePayment(File image, int id) async {
    try {
      final results = await remoteDataSource.updatePayment(image, id);
      return Right(results);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Payment?>> getPayment(int id) async {
    try {
      final results = await remoteDataSource.getPayment(id);
      return Right(results!.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> finishOrder(int id) async {
    try {
      final results = await remoteDataSource.finishOrder(id);
      return Right(results);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
