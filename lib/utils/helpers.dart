import 'package:intl/intl.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';

String formatOrderType(String status) {
  switch (status) {
    case "unpaid":
      return "Belum Dibayar";
    case "processed":
      return "Sedang Diproses";
    case "finished":
      return "Selesai";
    case "cancelled":
      return "Dibatalkan";
    default:
      return "-";
  }
}

String formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd – kk:mm').format(dt);
}

int calculateTotal(List<int> prices, {int cost = 0}) {
  var total = 0;

  for (var price in prices) {
    total += price;
  }

  return total + cost;
}

List<int> toArray(List<DetailsCart> detailsCart) {
  List<int> results = [];

  for (var cart in detailsCart) {
    results.add(cart.quantity * cart.product.total);
  }

  return results;
}
