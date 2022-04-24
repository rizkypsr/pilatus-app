import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/category_local_data_source.dart';
import 'package:pilatusapp/data/datasources/category_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/category.dart';
import 'package:pilatusapp/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await remoteDataSource.getCategories();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
