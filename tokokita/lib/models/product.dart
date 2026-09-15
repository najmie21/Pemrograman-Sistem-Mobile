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
  Product(id: 'P001', name: 'Sepatu Adidas', price: 200000.0, imageUrl: 'img1.png', category: 'Fashion', stock: 15),
  Product(id: 'P002', name: 'Celana Jeans', price: 150000.0, imageUrl: 'img2.png', category: 'Fashion', stock: 5),
  Product(id: 'P003', name: 'Kemeja Flanel', price: 100000.0, imageUrl: 'img3.png', category: 'Fashion', stock: 8),
  Product(id: 'P004', name: 'Iphone 17', price: 18000000.0, imageUrl: 'img4.png', category: 'Elektronik', stock: 3),
  Product(id: 'P005', name: 'Kripik Kentang', price: 18000.0, imageUrl: 'img5.png', category: 'Makanan', stock: 16),
  Product(id: 'P006', name: 'Donat Gula', price: 6000.0, imageUrl: 'img6.png', category: 'Makanan', stock: 20),
  Product(id: 'P007', name: 'Laptop Gaming', price: 12000000.0, imageUrl: 'img7.png', category: 'Elektronik', stock: 4),
  Product(id: 'P008', name: 'Sweater', price: 75000.0, imageUrl: 'img8.png', category: 'Fashion', stock: 7),
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