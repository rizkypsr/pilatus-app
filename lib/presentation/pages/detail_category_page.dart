import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/presentation/cubit/category_cubit.dart';
import 'package:pilatusapp/presentation/cubit/products_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/dummy.dart';
import 'package:pilatusapp/utils/routes.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).fetchProductsByCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Kategori"),
      body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is ProductsHasData) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, detailProductPageRoute,
                        arguments: 1);
                  },
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              maxCrossAxisExtent: 270),
                      itemCount: state.results.length,
                      itemBuilder: (ctx, index) {
                        return ProductItem(
                          product: state.results[index],
                        );
                      }),
                );
              } else {
                return const Center(
                  child: Text('Tidak Ada Kategori'),
                );
              }
            },
          )),
    );
  }
}

PreferredSizeWidget _buildAppBar(title) {
  return AppBar(
    title: Text(title),
  );
}

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      width: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: "$baseUrl/images/${product.photo}",
              fit: BoxFit.cover,
              height: 100,
              width: MediaQuery.of(context).size.width,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }
}
