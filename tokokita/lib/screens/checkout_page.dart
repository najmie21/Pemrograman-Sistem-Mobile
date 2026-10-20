import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'main_page.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil memori CartController
    final CartController cartController = Get.find();

    // Mengelompokkan produk unik untuk ringkasan
    final uniqueProducts = cartController.cartItems.toSet().toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan'),
        backgroundColor: const Color.fromARGB(255, 225, 83, 130),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Daftar Ringkasan Barang yang Dipesan
            const Text('Rincian Barang:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: uniqueProducts.length,
              itemBuilder: (context, index) {
                final product = uniqueProducts[index];
                final int quantity = cartController.cartItems.where((p) => p.name == product.name).length;
                final double harga = product is DiscountedProduct ? product.getHargaFinal() : product.price;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('$quantity x \$${harga.toStringAsFixed(2)}'),
                    trailing: Text(
                      '\$${(harga * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 225, 83, 130),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Ringkasan Pembayaran
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Jumlah Barang:'),
                        Text('${cartController.totalItem} pcs', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          '\$${cartController.totalHarga.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 225, 83, 130),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Tombol Bayar Sekarang di Bawah Layar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // 1. Kosongkan keranjang karena sudah dibayar
            cartController.cartItems.clear();

            // 2. Kembali ke Halaman Utama (MainPage) dan hapus seluruh stack riwayat
            Get.offAll(() => const MainPage());

            // 3. Tampilkan pesan berhasil bayar
            Get.snackbar(
              'Pembayaran Berhasil',
              'Terima kasih.',
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(16),
            );
          },
          child: const Text('Bayar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
