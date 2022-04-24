import 'package:flutter/material.dart';

class ButtomNavWidget extends StatelessWidget {
  const ButtomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), label: 'Beranda'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), label: 'Kategori'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home_filled), label: 'Transaksi'),
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Akun')
      ],
      currentIndex: 0,
      showUnselectedLabels: true,
    );
  }
}
