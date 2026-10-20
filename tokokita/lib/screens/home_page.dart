import 'package:flutter/material.dart';
import '../models/product.dart'; 
import '../widgets/product_card.dart';
import '../services/product_service.dart';


class HomePage extends StatefulWidget {
 const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _productsFuture;

  @override
  initState(){
    super.initState();
    _loadProducts();
  }

  void _loadProducts(){
    setState(() {
      _productsFuture = _productService.fetchProducts();
    });
  }

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
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  // LANGKAH 4.3: Loading indicator saat data masih dimuat
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Color.fromARGB(255, 225, 83, 130)),
                          SizedBox(height: 12),
                          Text('Sedang memuat produk asli dari API...'),
                        ],
                      ),
                    );
                  }

                  //tampilan pesan error
                  if (snapshot.hasError){
                    return Center(
                      child: Padding(
                        padding: const EdgeInsetsGeometry.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                            const SizedBox(height: 16),

                            const Text(
                              'Gagal memuat produk, coba lagi',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 12),

                            //Tombol 'coba lagi'
                            ElevatedButton.icon(
                              onPressed: _loadProducts,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Coba Lagi'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 225, 83, 130),
                                foregroundColor: Colors.white

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];
                  
                  // TUGAS MANDIRI 2: Menambahkan RefreshIndicator
                  return RefreshIndicator(
                    color: const Color.fromARGB(255, 225, 83, 130),
                    onRefresh: () async {
                      _loadProducts(); // Memuat ulang data saat ditarik
                      await _productsFuture;
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}