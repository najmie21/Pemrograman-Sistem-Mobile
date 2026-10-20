import 'package:flutter/material.dart';
//widget label harga
class PriceLabel extends StatelessWidget{
  final double price;

  const PriceLabel({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
  '\$${price.toStringAsFixed(2)}', // Menggunakan simbol $ dan menampilkan 2 angka desimal (misal: $12.99)
  style: const TextStyle(
    fontSize: 16, 
    color: Color.fromARGB(255, 25, 100, 27), 
    fontWeight: FontWeight.bold,
  ),
);
  }
}