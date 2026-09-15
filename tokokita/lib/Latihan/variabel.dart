void main () {
  // mendeklarasikan var, final, const 
  var namaKasir = 'Laila';
  final waktuInput = DateTime.now();
  const namaToko = 'Toko Serba Ada';

  namaKasir = 'Diva'; // bisa diubah karena var
// waktuInput = DateTime.now(); // tidak bisa diubah karena final
// namaToko = 'Toko Daily'; // tidak bisa diubah karena const

print('Nama Kasir: $namaKasir');
print('Waktu Input: $waktuInput');
print('Nama Toko: $namaToko');

// deklaraso tipe data
int stokBarang = 15;
double hargaBarang = 200000.0;
String nama= 'Sepatu Adidas';
bool isTersedia = true;

print('Nama Barang: $nama');
print('Harga Barang: $hargaBarang');
print('Stok Barang: $stokBarang');
print('Tersedia: $isTersedia');

// deklarasi tipe data list dan map
List<String> kategoriBarang = ['Elektronik', 'Fashion', 'Makanan'];
// list bisa diubah, tapi tipe data harus sama
Map<String, dynamic> produkMentah = {
  'kode barang': 'P001',
  'nama': 'Sepatu Adidas',
  'harga': 200000,
  'stok': 15,
  'kategori': 'Fashion'
};
 
print('Daftar Kategori: $kategoriBarang');
print('Data Mentah: $produkMentah');
// map bisa diubah, tapi tipe data harus sama
//beda nya list itu index nya angka, map itu key nya string
//index pada list itu urutannya, sedangkan key pada map itu bebas
}