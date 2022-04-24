import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 10),
      width: 190,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network("https://picsum.photos/300/200",
                fit: BoxFit.cover, height: 100),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            formatCurrency.format(product.total),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
