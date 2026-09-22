import 'package:flutter/material.dart';
//Widget Status Stok
class StockBadge extends StatelessWidget {
  final String status;

  const StockBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    //Logika warna berdasrkan stok
    Color badgecolor = status == 'Tersedia' ? Colors.green : (status == 'Habis' ? Colors.red : Colors.orange);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
      decoration: BoxDecoration(
        color: badgecolor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
