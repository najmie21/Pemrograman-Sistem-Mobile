import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/price_label.dart';
import '../widgets/category_tag.dart';
import '../widgets/stock_badge.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

// STATEFUL WIDGET 
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Variabel untuk menyimpan jumlah barang yang akan dimasukkan keranjang
  int _quantity = 1; 

  @override
  Widget build(BuildContext context) {
    //memanggil memori keranjang yang dibuat di mainPage
    final CartController cartController = Get.find();

    // LANGKAH 2
    //menangkao data argumen
    final Product product = Get.arguments as Product;

    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: const Color.fromARGB(255, 225, 83, 130),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //kembali ke halaman sebelumnya menggunakan GetX
            Get.back(); 
          }
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            //KARTU INFORMASI
            Container(
              //gambar produk (place holder)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 244, 135, 186),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Icon(Icons.image, size: 120, color: Color.fromARGB(255, 197, 19, 102)),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        
                        PriceLabel(
                          price: product is DiscountedProduct 
                              ? product.getHargaFinal() 
                              : product.price
                        ),
                        const SizedBox(height: 16), 
                        
                        Row(
                          children: [
                            const Text('Kategori: ', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            CategoryTag(category: product.category),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        Row(
                          children: [
                            const Text('Status: ', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            StockBadge(status: product.getStatusStok()),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        Text('Jumlah Stok: ${product.stock}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            
            // --- DESKRIPSI PRODUK
            const Text('Deskripsi Produk:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              product.description ?? 'Tidak ada deskripsi produk.', 
              style: const TextStyle(fontSize: 16, color: Colors.black87), 
            ),
            
            const SizedBox(height: 24),

            // --- TAMBAHAN BARU: FITUR TAMBAH/KURANG KUANTITAS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Atur Jumlah:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) _quantity--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      color: const Color.fromARGB(255, 225, 83, 130),
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity < product.stock) _quantity++;
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      color: const Color.fromARGB(255, 225, 83, 130),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // LANGKAH 3 tombol tambah keranjang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color.fromARGB(255, 225, 83, 130),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Menambahkan produk ke keranjang menggunakan CartController
                  for (int i = 0; i < _quantity; i++) {
                    cartController.addToCart(product);
                  }

                  // menggunakan get.back untuk kembali dan membawa pesan snackbar
                  Get.back(result: '${product.name} sejumlah $_quantity berhasil ditambahkan!');
                },
                child: const Text('Tambahkan ke Keranjang', style: TextStyle(fontSize: 16)),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

