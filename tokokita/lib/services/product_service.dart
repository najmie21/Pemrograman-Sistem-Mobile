import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  // 1. Mengambil semua produk
  Future<List<Product>> fetchProducts() async {
   

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      print('=== HTTP GET Products ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Gagal memuat produk, dari server. Status (${response.statusCode})');
      }
    } catch (e) {
       print('Error saat fetchProducts: $e');
      throw Exception('Terjadi kesalahan jaringan / gagal memuat data: $e');
    }
  }

  // 2. Mengambil detail 1 produk (Tugas Mandiri 1)
  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return Product.fromJson(jsonData);
      } else {
        throw Exception('Gagal memuat detail produk (${response.statusCode})');
      }
    } catch (e) {

      throw Exception('Terjadi kesalahan saat memuat detail: $e');
    }
  }
}
