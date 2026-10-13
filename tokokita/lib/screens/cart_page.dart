import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controllers/cart_controller.dart';
import '../models/product.dart'; // Untuk tujuan rute Get.off()
import 'checkout_page.dart'; 

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Panggil memori keranjang yang sudah aktif
    final CartController cartController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
        backgroundColor: const Color.fromARGB(255, 225, 83, 130),
        foregroundColor: Colors.white,
        //  Menyembunyikan tombol back bawaan karena pakai Bottom Navbar
        automaticallyImplyLeading: false, 

        actions: [
          Obx(() {
            if (cartController.cartItems.isEmpty)
              return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  // Panggil method konfirmasiKosongkanKeranjang dari CartController
                  cartController.konfirmasiKosongkanKeranjang();
                },
              );
            }),
        ]
      ),
      
      // 2. Bungkus body dengan Obx agar daftar dan total harga langsung berubah
      body: Obx(() {
        // Jika keranjang kosong
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Keranjang belanja kosong!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        //Mengelompokkan produk unik agar 1 produk hanya 1 baris kartu
        final uniqueProducts = cartController.cartItems.toSet().toList();

        // Jika keranjang ada isinya
        return Column(
          children: [
            // DAFTAR PRODUK DI KERANJANG
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: uniqueProducts.length,
                itemBuilder: (context, index) {
                  final product = uniqueProducts[index];

                  final quantity = cartController.cartItems.where((p) => p.name == product.name).length;
                  // Hitung harga 
                  double itemPrice = product is DiscountedProduct 
                      ? product.getHargaFinal() 
                      : product.price;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 135, 186),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                      title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Rp ${itemPrice.toStringAsFixed(0)}',
                        style: const TextStyle(color: Color.fromARGB(255, 225, 83, 130), fontWeight: FontWeight.w600),
                      ),


                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tombol Kurangi Kuantitas
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () {
                              cartController.hapusSatuBarang(product);
                            },
                          ),
                          
                          // Teks Kuantitas
                          Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          
                          // Tombol Tambah Kuantitas
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: () {
                              cartController.addToCart(product);
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              cartController.removeFromCart(product);
                              Get.snackbar(
                              'Dihapus',
                              '${product.name} berhasil dihapus dari keranjang!',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(12),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // --- BAGIAN BAWAH: TOTAL HARGA & TOMBOL CHECKOUT ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Teks Total Harga
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Harga:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(
                        'Rp ${cartController.totalHarga.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.bold, 
                          color: Color.fromARGB(255, 225, 83, 130)
                        ),
                      ),
                    ],
                  ),
                  
                  // Tombol Checkout (Implementasi Get.off Langkah 4)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      
                      // 2. Pindah ke halaman utama tanpa bisa kembali (Get.off)
                      Get.off(() => const CheckoutPage());
                    },
                    child: const Text('Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}