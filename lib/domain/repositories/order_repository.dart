import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/order.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';
import 'package:pilatusapp/domain/entities/payment.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Orders>>> getOrders(String status);
  Future<Either<Failure, OrderDetail>> getOrderDetail(int id);
  Future<Either<Failure, int>> addOrder(Map<String, dynamic> order);
  Future<Either<Failure, String>> updatePayment(File image, int id);
  Future<Either<Failure, String>> finishOrder(int id);
  Future<Either<Failure, Payment?>> getPayment(int id);
}
