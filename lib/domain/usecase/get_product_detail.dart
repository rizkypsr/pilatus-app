import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';
import 'package:pilatusapp/domain/repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;

  GetProductDetail(this.repository);

  Future<Either<Failure, ProductDetail>> execute(int id) {
    return repository.getProductDetail(id);
  }
}
