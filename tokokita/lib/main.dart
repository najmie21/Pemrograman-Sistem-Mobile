import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart'; 
import 'screens/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      
      // Aplikasi dibuka pertama kali langsung ke rute '/' (MainPage)
      initialRoute: '/', 
      
      routes: {
        '/': (context) => const MainPage(), // Halaman default: MainPage (beserta navbar dan HomePage)
        '/detail': (context) => const ProductDetailPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}