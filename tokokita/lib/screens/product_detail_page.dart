import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/price_label.dart';
import '../widgets/category_tag.dart';
import '../widgets/stock_badge.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../services/product_service.dart';

// STATEFUL WIDGET 
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductService _productService = ProductService();
  late Product _initialProduct;
  Future<Product>? _detailFuture;

  // Variabel untuk menyimpan jumlah barang yang akan dimasukkan keranjang
  int _quantity = 1; 

  @override
  void initState() {
    super.initState();
    // 1. Menangkap objek produk yang dikirim lewat navigasi
    _initialProduct = Get.arguments as Product;

    // 2. Memanggil data detail dari API Fake Store
    final int? productId = int.tryParse(_initialProduct.id);
    if (productId != null) {
      _detailFuture = _productService.fetchProductDetail(productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memanggil memori keranjang yang dibuat di mainPage
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: const Color.fromARGB(255, 225, 83, 130),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke halaman sebelumnya menggunakan GetX
            Get.back(); 
          },
        ),
      ),
      
      body: FutureBuilder<Product>(
        future: _detailFuture,
        builder: (context, snapshot) {
          // Saat API masih memuat detail, tampilkan loading indikator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color.fromARGB(255, 225, 83, 130)),
            );
          }

          final product = snapshot.data ?? _initialProduct;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // KARTU INFORMASI
                Container(
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
                      // Gambar Produk
                      Container(
                        height: 250,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Center(
                          child: product.imageUrl.startsWith('http')
                              ? Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (ctx, err, stack) => const Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Color.fromARGB(255, 197, 19, 102),
                                  ),
                                )
                              : const Icon(
                                  Icons.image, 
                                  size: 120, 
                                  color: Color.fromARGB(255, 197, 19, 102),
                                ),
                        ),
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
                                  : product.price,
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
                
                // DESKRIPSI PRODUK
                const Text('Deskripsi Produk:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  product.description ?? 'Tidak ada deskripsi produk.', 
                  style: const TextStyle(fontSize: 16, color: Colors.black87), 
                ),
                
                const SizedBox(height: 24),

                // FITUR TAMBAH/KURANG KUANTITAS
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

                // TOMBOL TAMBAH KE KERANJANG
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color.fromARGB(255, 225, 83, 130),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      for (int i = 0; i < _quantity; i++) {
                        cartController.addToCart(product);
                      }
                      Get.back(result: '${product.name} sejumlah $_quantity berhasil ditambahkan!');
                    },
                    child: const Text('Tambahkan ke Keranjang', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
