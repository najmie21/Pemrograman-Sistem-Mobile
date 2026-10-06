import 'package:flutter/material.dart';
import '../models/product.dart'; 
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Teks di Kiri
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'TokoKita',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 225, 83, 130)),
                      ),
                      SizedBox(height: 4),
                      Text('Selamat Datang di TokoKita', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  
                  // Tombol Login di Kanan Atas
                  IconButton(
                  icon: const Icon(
                    Icons.login, 
                    color: Color.fromARGB(255, 225, 83, 130),
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  ),
                ],
              ),
            ),
            
            // --- DAFTAR PRODUK ---
            Expanded(
              child: ListView.builder(
                itemCount: daftarProduk.length, 
                itemBuilder: (context, index) {
                  return ProductCard(product: daftarProduk[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}