import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Teks yang kamu minta
            const Text(
              'ini halaman login', 
              style: TextStyle(fontSize: 20)
            ),
            const SizedBox(height: 24), // Jarak antara teks dan tombol
            
            // Tombol masuk ke beranda
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 225, 83, 130), 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Menggunakan pushReplacement agar setelah masuk beranda, tidak bisa di-back ke login
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Masuk ke Beranda', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}