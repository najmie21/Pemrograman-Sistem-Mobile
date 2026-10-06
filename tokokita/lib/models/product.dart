//class product & null safety
class Product {
  String id;
  String name;
  double price;
  String imageUrl;
  String category;
  int stock;

// null safety : tanda '?' berarti description boleh dikosongkan
  String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.description,
  });

//tugas mandiri 1
  String getStatusStok() {
  if (stock > 10) {
    return 'Tersedia';
  } else if (stock > 0 && stock <= 10) {
    return 'Stok Terbatas';
  } else {
    return 'Habis';
  }
}
}

//Class Turunan
class DiscountedProduct extends Product {
  double discountPercent;
    DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });
  
  //method untuk menghitung harga setelah diskon
  double getHargaFinal() {
    return price - (price * (discountPercent / 100));
  }
}

// tugas mandiri 3 function hitungTotalBelanja
double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0.0;
  for (var produk in keranjang) {
    total += produk.price;
  }
  return total;
}


// tugas mandiri 2, 8 dummy data
List<Product> daftarProduk = [

  Product(id: 'P001', name: 'Sepatu Adidas', price: 200000.0, imageUrl: 'img1.png', category: 'Fashion', stock: 15, description: 'Sepatu Adidas original, nyaman dipakai untuk olahraga dan aktivitas sehari-hari'),
  DiscountedProduct(id: 'P002', name: 'Celana Jeans', price: 150000.0, imageUrl: 'img2.png', category: 'Fashion', stock: 5, discountPercent: 20.0),
  Product(id: 'P003', name: 'Kemeja Flanel', price: 100000.0, imageUrl: 'img3.png', category: 'Fashion', stock: 8, description: 'Kemeja flanel berkualitas tinggi, nyaman dipakai di cuaca dingin'),
  Product(id: 'P004', name: 'Iphone 17', price: 18000000.0, imageUrl: 'img4.png', category: 'Elektronik', stock: 3, description: 'Iphone 17 terbaru dengan fitur canggih, kamera berkualitas tinggi, dan performa yang cepat. Cocok untuk pengguna yang menginginkan pengalaman smartphone premium.'),
  Product(id: 'P005', name: 'Kripik Kentang', price: 18000.0, imageUrl: 'img5.png', category: 'Makanan', stock: 16),
  Product(id: 'P006', name: 'Donat Gula', price: 6000.0, imageUrl: 'img6.png', category: 'Makanan', stock: 20),
  DiscountedProduct(id: 'P007', name: 'Laptop Gaming', price: 12000000.0, imageUrl: 'img7.png', category: 'Elektronik', stock: 4, discountPercent: 30.0),
  Product(id: 'P008', name: 'Tas Ransel', price: 75000.0, imageUrl: 'img8.png', category: 'Fashion', stock: 7),
  
  Product(id: 'P009', name: 'Earphone TWS', price: 350000.0, imageUrl: 'img9.png', category: 'Elektronik', stock: 5),
  Product(id: 'P010', name: 'Monitor 24 Inch', price: 2500000.0, imageUrl: 'img10.png', category: 'Elektronik', stock: 10),
  Product(id: 'P011', name: 'Es Teh Manis', price: 6000.0, imageUrl: 'img11.png', category: 'Makanan', stock: 12),
  Product(id: 'P012', name: 'Kopi Susu Gula Aren', price: 20000.0, imageUrl: 'img12.png', category: 'Makanan', stock: 20),
  Product(id: 'P013', name: 'Topi Pantai', price: 55000.0, imageUrl: 'img13.png', category: 'Fashion', stock: 14),
  Product(id: 'P014', name: 'Smartwatch', price: 1500000.0, imageUrl: 'img14.png', category: 'Elektronik', stock: 7),
  Product(id: 'P015', name: 'Pashmina Viscose', price: 45000.0, imageUrl: 'img15.png', category: 'Fashion', stock: 18),
  Product(id: 'P016', name: 'Susu UHT 1 Liter', price: 18000.0, imageUrl: 'img16.png', category: 'Makanan', stock: 25),
  Product(id: 'P017', name: 'Jaket Kulit', price: 350000.0, imageUrl: 'img17.png', category: 'Fashion', stock: 8)
];

void main() {
//class product biasa
Product produkBiasa = Product(
  id: 'P001',
  name: 'Sepatu Adidas',
  price: 200000.0,
  imageUrl: 'img1.png',
  category: 'Fashion',
  stock: 15,
);

print('Info Produk Biasa');
print('Nama Produk: ${produkBiasa.name}');  
print('Harga Produk: Rp ${produkBiasa.price}\n');


//class turunan diskonProduk
DiscountedProduct produkDiskon = DiscountedProduct(
  id: 'P009',
  name: 'Jaket Kulit',
  price: 500000.0,
  imageUrl: 'img9.png',
  category: 'Fashion',
  stock: 12, 
  discountPercent: 20.0,
);

print('Info Produk Diskon');
print('Nama Produk: ${produkDiskon.name}');
print('Harga Awal: Rp ${produkDiskon.price}');
print('Harga Setelah Diskon: Rp ${produkDiskon.getHargaFinal()}\n');

  // Untuk melihat error null safety  
  // produk1.name = null;

print('Tugas Mandiri 1: Status Stok Produk');
print('stok ${produkBiasa.name}: ${produkBiasa.stock} -> status ${produkBiasa.getStatusStok()}\n');

print('Tugas Mandiri 3: Total Belanja');
double totalBelanja = hitungTotalBelanja(daftarProduk);
print('Total belanja dari daftar produk: Rp $totalBelanja');
}