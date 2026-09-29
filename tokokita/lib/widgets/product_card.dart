import 'package:flutter/material.dart';
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
    print('build: Membangun kartu produk ${widget.product.name}');
    return Container(
      //margin = JARAK LUAR ANTAR KARTU
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      // decoration (warna, sudut melekung, bayangan)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          //efek bayangan
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.8),
            blurRadius: 8, //tingkat buram
            offset: const Offset(0, 4), //posisi bayangan ke bawah
          ),
        ],
      ),

      //Padding 
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //langkah 3
            Stack(//langkah 3
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 135, 186),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, size: 80, color: Color.fromARGB(255, 197, 19, 102)),
                ),

                //lapisan atas : badge diskon
                if (widget.product is DiscountedProduct)
                Positioned(
                  top: 8, //Jarak 8 pixel dari batas atas gambar
                  right: 8, //Jarak 8 pixel dari batas kanan gambar
                  child:
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical:  6),
                    decoration: BoxDecoration(
                      color:const Color.fromARGB(255, 189, 13, 42),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Diskon', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //Tugas Mandiri no 2
                Positioned(
                  top: 8, left: 8,
                  child: StockBadge(status: widget.product.getStatusStok()),
                ),
              ],
            ),
          

            //teks dan tombol ikon favorite
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // langkah 5 expanded
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),
                    PriceLabel(price: widget.product.price),

                    // jika harga setelah diskon yg ditampilkan
                    // PriceLabel(
                    //   price: widget.product is DiscountedProduct 
                    //       ? (widget.product as DiscountedProduct).getHargaFinal() 
                    //       : widget.product.price
                    // ),

                    // const SizedBox(height: 4),
                    // StockBadge(status: widget.product.getStatusStok()),

                    const SizedBox(height: 4),
                    CategoryTag(category: widget.product.category),
                  ],
                ),
              ), 
                //ikon favorite
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite: Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 32,
                  ),
                  onPressed: (){
                    setState((){
                      isFavorite = !isFavorite;
                    });
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}