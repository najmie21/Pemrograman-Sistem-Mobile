import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('Halaman Keranjang Belanja', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}