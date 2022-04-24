import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, ProductDetail>> getProductDetail(int id);
  Future<Either<Failure, List<Product>>> getProductsByCategory(int categoryId);
}
