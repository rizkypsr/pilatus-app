import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/data/datasources/product_local_data_source.dart';
import 'package:pilatusapp/data/datasources/product_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';
import 'package:pilatusapp/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductDetail>> getProductDetail(int id) async {
    try {
      final results = await remoteDataSource.getProductDetail(id);
      return Right(results.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      int categoryId) async {
    try {
      final result = await remoteDataSource.getProductByCategory(categoryId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
