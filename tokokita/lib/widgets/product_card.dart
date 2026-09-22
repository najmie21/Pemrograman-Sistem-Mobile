
//langkah 3
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'price_label.dart'; // Memanggil file price_label.dart
import 'stock_badge.dart'; // Memanggil file stock_badge.dart
import 'category_tag.dart'; //memanggil file kategory.dart

// widget utama
class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  void initState(){
    super.initState();
    print('LIFE CYCLE - initState: Kartu produk ${widget.product.name} muncul');
  }

   @override
  void dispose(){
    print('LIFE CYCLE - dispose: Kartu produk ${widget.product.name} dihapus');
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    print('build: Membangun kartu produk ${widget.product.name}');

    return Card(
      elevation: 4, //bayangan
      margin: const EdgeInsets.all(12), //jarak antar kartu lain
      clipBehavior: Clip.antiAlias, // gambar di dalamnya terpotong rapi mengikuti lengkungan kartu
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //menampilkan gambar besar
          Container(
            height: 180,
            width: double.infinity, //lebar ditarik penuh
            color: const Color.fromARGB(255, 244, 135, 186),
            child: const Icon(Icons.image, size: 80, color: Color.fromARGB(255, 197, 19, 102)),
          ),

          // Teks dan Tombol Favorite
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    
                    // Memanggil widget PriceLabel yang dibuat
                    PriceLabel(price: widget.product.price),
                    
                    // Memanggil widget StockBadge yang dibuat
                    StockBadge(status: widget.product.getStatusStok()), 

                    // Memanggil widget pendukung tag kategori
                    CategoryTag(category: widget.product.category)
                  ],
                ),

                // Tombol Favorite
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 32,
                  ),
                  onPressed: () {
                    setState((){
                      print('setState: Tombol favorit [${widget.product.name}] ditekan.');
                      isFavorite = !isFavorite;
                    });
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

