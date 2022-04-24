import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';
import 'package:pilatusapp/presentation/cubit/cart_cubit.dart';
import 'package:pilatusapp/presentation/cubit/product_detail_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductDetailCubit>(context)
        .fetchProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar('Detail Produk'),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductDetailError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ProductDetailHasData) {
              return ProductDetailView(productDetail: state.product);
            } else {
              return const Center(
                child: Text('Produk tidak ditemukan'),
              );
            }
          },
        ));
  }
}

PreferredSizeWidget _buildAppBar(title) {
  return AppBar(
    title: Text(title),
    centerTitle: false,
  );
}

class ProductDetailView extends StatelessWidget {
  ProductDetailView({Key? key, required this.productDetail}) : super(key: key);

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  final ProductDetail productDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '$baseUrl/images/${productDetail.photo}',
                          fit: BoxFit.cover,
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (_, __) => Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                height: 90,
                                width: 120,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              )),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(productDetail.name, style: kHeading6),
                        const SizedBox(height: 10),
                        Text(
                          formatCurrency.format(productDetail.total),
                          style:
                              kHeading6.copyWith(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Detail Produk',
                            style: kSubtitle.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Stok : ",
                                style: kBodyText.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Text(productDetail.stock.toString(),
                                style: kBodyText),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Berat : ",
                                style: kBodyText.copyWith(
                                    fontWeight: FontWeight.bold)),
                            Text("${productDetail.weight.toString()} Gram",
                                style: kBodyText),
                          ],
                        ),
                        const Divider(),
                        Text('Deskripsi Produk',
                            style: kSubtitle.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(productDetail.description, style: kBodyText),
                      ]),
                ),
              ],
            ),
          ),
        ),
        BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartAdded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                height: 70,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context)
                        .addToCart(productDetail.id);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_cart_rounded),
                      Text("TAMBAHKAN KE KERANJANG")
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
