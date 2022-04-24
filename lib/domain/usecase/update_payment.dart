import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';

class UpdatePayment {
  final OrderRepository repository;

  UpdatePayment(this.repository);

  Future<Either<Failure, String>> execute(File image, int id) {
    return repository.updatePayment(image, id);
  }
}
