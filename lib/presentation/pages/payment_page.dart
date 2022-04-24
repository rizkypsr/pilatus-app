import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/presentation/cubit/bank_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/presentation/cubit/payment_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.orderId}) : super(key: key);

  final int orderId;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  XFile? imageFile;

  Future<XFile?> getImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  void _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final result = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = result!;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentCubit>(context).fetchPayment(widget.orderId);
    BlocProvider.of<BankCubit>(context).getBankAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (imageFile != null) {
                  BlocProvider.of<OrderCubit>(context).updatePaymentOrder(
                      File(imageFile!.path), widget.orderId);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Pilih gambar terlebih dahulu")));
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<BankCubit, BankState>(
              builder: (context, state) {
                if (state is BankHasData) {
                  return Text(
                    "Transfer ke: ${state.bank.id} - ${state.bank.bank} (${state.bank.owner})",
                    style: kHeading6,
                  );
                }

                return const SizedBox();
              },
            ),
            const Divider(),
            BlocListener<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is OrderUpdated) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                  Navigator.pop(context);
                } else if (state is OrderError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        _openGallery(context);
                      },
                      child: const Text("Pilih Foto"))),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PaymentError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is PaymentHasData) {
                  if (imageFile != null) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 250,
                        child: Image.file(File(imageFile!.path)));
                  } else if (state.payment!.id != null) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 250,
                        child: Image.network(
                            '$baseUrl/storage/${state.payment!.photo}'));
                  }

                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 250,
                      child: const Icon(Icons.image));
                }

                return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 250,
                    child: imageFile != null
                        ? Image.file(File(imageFile!.path))
                        : const Icon(Icons.image));
              },
            ),
          ],
        ),
      ),
    );
  }
}
