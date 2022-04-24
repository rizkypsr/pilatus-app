import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/presentation/cubit/products_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsHasData) {
            return ProductList(
              products: state.results,
            );
          } else if (state is ProductsError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('No Products Found'),
            );
          }
        },
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(context) {
  return AppBar(
    title: const Text('Pilatus Showroom'),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            cartPageRoute,
          );
        },
        icon: const Icon(Icons.shopping_cart_rounded),
      )
    ],
  );
}

class ProductList extends StatelessWidget {
  const ProductList({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductItem(product: products[index]));
  }
}

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, detailProductPageRoute,
            arguments: product.id);
      },
      child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: "$baseUrl/images/${product.photo}",
                imageBuilder: (_, imageProvider) => Container(
                    height: 90,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider),
                    )),
                placeholder: (_, __) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 90,
                      width: 120,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  Text(
                    formatCurrency.format(product.total),
                    style: kSubtitle,
                  )
                ],
              )
            ],
          )),
    );
  }
}
