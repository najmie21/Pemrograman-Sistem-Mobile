import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/product_detail_page.dart';
import '../models/product.dart';
import 'price_label.dart';
import 'stock_badge.dart';
import 'category_tag.dart';


class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    
    // BUNGKUS DENGAN GESTURE DETECTOR
    return GestureDetector(
      onTap: () async {
        //routing getX : pindah halaman menuju detail produk
         final result = await Get.to(
            () => const ProductDetailPage(),
            arguments: widget.product,
          );

        // menampilkan notifikasi snackbar jika ada hasil dari halaman detail
        if (result != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.toString()),
              backgroundColor: Colors.green, // Warna snackbar hijau 
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.8),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          
          //  MENGGUNAKAN ROW UNTUK MENJEJERKAN KIRI (GAMBAR) DAN KANAN (TEKS)
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // 1. BAGIAN KIRI: GAMBAR & BADGE (Dibungkus Stack)
                           // 1. BAGIAN KIRI: GAMBAR DARI INTERNET & BADGE (Dibungkus Stack)
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    padding: const EdgeInsets.all(8), // Beri jarak sedikit agar rapi
                    decoration: BoxDecoration(
                      color: Colors.white, // Ganti background jadi putih agar foto produk terlihat jelas
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    // 👇 CEK APAKAH GAMBAR DARI URL INTERNET (HTTP) 👇
                    child: widget.product.imageUrl.startsWith('http')
                        ? Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.contain, // Agar foto produk proporsional dan tidak terpotong
                            // Saat gambar masih loading dimuat:
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              );
                            },
                            // Jika gambar gagal dimuat / URL rusak:
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 60, color: Colors.grey);
                            },
                          )
                        // Jika bukan dari internet (data dummy lokal lama), tampilkan ikon bawaan:
                        : const Icon(
                            Icons.image,
                            size: 60,
                            color: Color.fromARGB(255, 197, 19, 102),
                          ),
                  ),
                  
                  // (Badge Diskon dan Badge Status Stok di bawahnya TETAP BIARKAN SAJA SEPERTI SEMULA)

                  
                  // Badge Diskon
                  if (widget.product is DiscountedProduct)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 189, 13, 42),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Diskon', 
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  // Badge Status Stok
                  Positioned(
                    top: 4, 
                    left: 4,
                    child: StockBadge(status: widget.product.getStatusStok()),
                  ),
                ],
              ),
              
              // Jarak pemisah antara gambar dan teks
              const SizedBox(width: 12), 

              // 2. BAGIAN KANAN: TEKS & TOMBOL (Dibungkus Expanded agar fleksibel)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    // Kelompok Teks (Nama, Harga, Kategori)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 2, 
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          PriceLabel(
                            price: widget.product is DiscountedProduct 
                                ? (widget.product as DiscountedProduct).getHargaFinal() 
                                : widget.product.price
                          ),
                          const SizedBox(height: 4),
                          CategoryTag(category: widget.product.category),
                        ],
                      ),
                    ), 
                    
                    // Ikon Tombol Favorit
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite: Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                      onPressed: (){
                        setState((){
                          isFavorite = !isFavorite;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}