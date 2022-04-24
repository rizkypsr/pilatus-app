import 'dart:io';

import 'package:pilatusapp/common/exception.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pilatusapp/data/datasources/auth_local_data_source.dart';
import 'package:pilatusapp/data/datasources/auth_remote_data_source.dart';
import 'package:pilatusapp/domain/entities/auth.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Auth>> login(User user) async {
    try {
      final result = await remoteDataSource.login(user);
      return Right(result.toEntity());
    } on AuthenticationException {
      return const Left(AuthenticationFailure('Email atau password salah'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final result = await localDataSource.removeToken();
    return Right(result);
  }

  @override
  Future<Either<Failure, Auth>> register(Map<String, String> data) async {
    try {
      final result = await remoteDataSource.register(data);
      return Right(result.toEntity());
    } on AuthenticationException {
      return const Left(AuthenticationFailure('Email sudah digunakan'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveToken(String token) async {
    try {
      final result = await localDataSource.saveToken(token);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<String?> getToken() async {
    final result = await localDataSource.getToken();
    return result;
  }
}
