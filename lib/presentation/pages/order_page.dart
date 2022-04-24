import 'package:flutter/material.dart';
import 'package:pilatusapp/presentation/pages/order_view_page.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(text: 'Belum Dibayar'),
            Tab(text: 'Diproses'),
            Tab(text: 'Selesai'),
          ]),
          title: const Text('Transaksi'),
        ),
        body: const TabBarView(children: [
          OrderViewPage(status: "unpaid"),
          OrderViewPage(status: "processed"),
          OrderViewPage(status: "finished"),
        ]),
      ),
    );
  }
}
