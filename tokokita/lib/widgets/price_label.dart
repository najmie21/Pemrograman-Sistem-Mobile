import 'package:flutter/material.dart';
//widget label harga
class PriceLabel extends StatelessWidget{
  final double price;

  const PriceLabel({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Rp ${price.toInt()}', //toInt agar angka .0 dibelakng hilang
      style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 25, 100, 27), fontWeight: FontWeight.bold),
    );
  }
}