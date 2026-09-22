import 'package:flutter/material.dart';
import 'models/product.dart'; // Tempat daftarProduk berada
import 'widgets/product_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('TokoKita')),
        // Menampilkan daftar produk menggunakan kartu yang di buat
        body: ListView.builder(
          itemCount: daftarProduk.length, 
          itemBuilder: (context, index) {
            return ProductCard(product: daftarProduk[index]);
          },
        ),
      ),
    );
  }
}