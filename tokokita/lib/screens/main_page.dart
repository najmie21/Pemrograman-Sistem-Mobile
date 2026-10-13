import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart'; // Memanggil CartController
import 'home_page.dart'; // Memanggil halaman beranda
import 'cart_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CartController cartController = Get.put(CartController()); 

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(), 
    const CartPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 225, 83, 130),
        items: [

          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),

          //ikon keranjang reactive menggunakan Obx
          BottomNavigationBarItem(
            icon: Obx(() => Badge (
              label: Text ('${cartController.totalItem}'),
              isLabelVisible: cartController.totalItem > 0,
              backgroundColor: const Color.fromARGB(255, 225, 83, 130),
              child: const Icon(Icons.shopping_cart),
            )),
            label: 'Keranjang',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}