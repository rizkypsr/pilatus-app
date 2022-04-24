import 'package:pilatusapp/common/enums.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/entities/cart.dart';
import 'package:pilatusapp/domain/entities/category.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';
import 'package:pilatusapp/domain/entities/details_order.dart';
import 'package:pilatusapp/domain/entities/order.dart';
import 'package:pilatusapp/domain/entities/payment.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/domain/entities/shipping.dart';

const listProducts = [
  Product(
      id: 1,
      name: 'Product 1 sxsd sds ds xs xs xsx sdsd',
      photo: 'photo',
      total: 90000,
      description: 'Description',
      stock: 1,
      weight: 2),
  Product(
      id: 1,
      name: 'Product 1 sxsd sds ds xs xs xsx sdsd',
      photo: 'photo',
      total: 90000,
      description: 'Description',
      stock: 1,
      weight: 2),
  Product(
      id: 1,
      name: 'Product 1 sxsd sds ds xs xs xsx sdsd',
      photo: 'photo',
      total: 90000,
      description: 'Description',
      stock: 1,
      weight: 2),
];

const listCategory = [
  Category(id: 1, name: 'Category 1'),
  Category(id: 2, name: 'Category 2'),
  Category(id: 3, name: 'Category 3'),
  Category(id: 4, name: 'Category 4'),
  Category(id: 5, name: 'Category 5'),
];

const productDetail = Product(
    id: 1,
    name: 'Product 2 dsjd sdjsd jsd sjdjsd sjd',
    photo: 'photo',
    total: 90000,
    description:
        'Description dshds suds ud sdsudsu dsudhsu dsdh suhdu sudhus duhsuhu dusduhsu dushu dsuhd ushu dsuhd ushud uhd ushud suhd ushdu sud ush duhsu dushd uhsu',
    stock: 1,
    weight: 1);

const cart = Cart(
  id: 1,
  detailsCart: [
    DetailsCart(id: 1, product: productDetail, quantity: 3),
    DetailsCart(id: 2, product: productDetail, quantity: 1),
  ],
);
