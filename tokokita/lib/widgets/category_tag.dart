import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {
  final String category;
  const CategoryTag({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 171, 238), // Warna latar biru muda
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(category, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 88, 9, 65))),
    );
  }
}