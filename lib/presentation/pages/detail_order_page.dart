import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/details_order.dart';
import 'package:pilatusapp/domain/entities/order_detail.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_detail_cubit.dart';
import 'package:pilatusapp/styles/colors.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/helpers.dart';
import 'package:pilatusapp/utils/routes.dart';

class DetailOrderPage extends StatefulWidget {
  const DetailOrderPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderDetailCubit>(context).fetchOrderDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkOnBackground,
        appBar: AppBar(
          title: const Text('Detail Pesanan'),
        ),
        body: BlocBuilder<OrderDetailCubit, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderDetailError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is OrderDetailHasData) {
              final order = state.orderDetail;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatOrderType(order.status),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, paymentPageRoute,
                                    arguments: order.id);
                              },
                              child: const Text("Bukti Pembayaran"),
                            ),
                          ],
                        ),
                        order.status == "processed"
                            ? const Divider()
                            : const SizedBox(),
                        order.status == "processed"
                            ? order.shipping != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("No. Resi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(order.shipping!.resi!),
                                    ],
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        order.status == "processed" && order.shipping == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Pengiriman",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Ambil Barang Di Toko'),
                                ],
                              )
                            : const SizedBox(),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Tanggal Pembelian'),
                            Text(formatDate(order.createdAt)),
                          ],
                        ),
                        BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state is OrderFinished) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)));
                              Navigator.pop(context);
                            }
                          },
                          child: const Divider(),
                        ),
                        order.status == "processed"
                            ? SizedBox(
                                width: double.maxFinite,
                                child: OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Apakah anda yakin ingin menyelesaikan pesanan ?"),
                                            titleTextStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                            actionsOverflowButtonSpacing: 20,
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Batal")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    BlocProvider.of<OrderCubit>(
                                                            context)
                                                        .finishTheOrder(
                                                            widget.id);
                                                  },
                                                  child:
                                                      const Text("Selesaikan")),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("Selesaikan Pesanan"),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detail Produk',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: order.detailOrders.length,
                                itemBuilder: (context, index) {
                                  return OrderProductList(
                                      order: order,
                                      detailOrder: order.detailOrders[index]);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("Transaksi tidak ditemukan"),
              );
            }
          },
        ));
  }
}

class OrderProductList extends StatelessWidget {
  OrderProductList({Key? key, required this.order, required this.detailOrder})
      : super(key: key);

  final OrderDetail order;
  final DetailOrder detailOrder;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: '$baseUrl/images/${detailOrder.products.photo}',
                width: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailOrder.products.name,
                      style: kHeading6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${detailOrder.quantity.toString()} barang',
                        style: kSubtitle2)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          const Text('Total Harga'),
          Text(
              formatCurrency
                  .format(detailOrder.products.total * detailOrder.quantity),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
