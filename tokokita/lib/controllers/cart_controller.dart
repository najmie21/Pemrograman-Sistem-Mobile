import 'package:get/get.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  // Variabel reaktif (RxList) untuk menyimpan barang yang masuk ke keranjang.
  // Akhiran .obs = bahwa variabel bisa dipantau perubahannya (reaktif).
  var cartItems = <Product>[].obs;

  //tugas mandiri nomor 1
  // Method untuk menambah produk ke keranjang
  void addToCart(Product product) {
    cartItems.add(product);
  }
  // Method untuk menghapus satu barang dari keranjang
  void hapusSatuBarang(Product product) {
    //mencari index barang pertama yang cocok, lalu hapus
    int index = cartItems.indexWhere((p) => p.name == product.name);
    if (index != -1) {
      cartItems.removeAt(index);
    }
  }
 // method Menghapus seluruh kuantitas produk dari keranjang
  void removeFromCart(Product product) {
    cartItems.removeWhere((p) => p.name == product.name);
  }


  // Getter reaktif untuk menghitung total jumlah barang di keranjang
  int get totalItem => cartItems.length;

  // Getter reaktif untuk menghitung total harga seluruh barang di keranjang
  double get totalHarga {
  double total = 0.0;
  for (var product in cartItems) {
    total += (product is DiscountedProduct ? product.getHargaFinal() : product.price);
  }
  return total;
}

  //tugas mandiri nomor 2
   void konfirmasiKosongkanKeranjang() {
    Get.defaultDialog(
      title: "Kosongkan Keranjang?",
      middleText: "Apakah kamu yakin ingin menghapus semua barang dari keranjang?",
      textConfirm: "Ya, Hapus",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.grey,
      onConfirm: () {
        // 1. Kosongkan seluruh isi memori keranjang
        cartItems.clear(); 
        // 2. Tutup modal dialog konfirmasi
        Get.back(); 
        // 3. Tampilkan pesan berhasil
        Get.snackbar(
          'Berhasil', 
          'Keranjang belanja telah dikosongkan',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}