// 1. Function dengan parameter biasa
// Argumen harus diisi berurutan (harga dulu, baru persenDiskon)
double hitungHargaSetelahDiskonBiasa(double harga, double persenDiskon) {
  return harga - (harga * (persenDiskon / 100));
}

// 2. Function dengan named parameter & nilai default (opsional)
// Menggunakan {} agar saat dipanggil bisa menyebutkan namanya (harga: ...)
// persenDiskon diberi nilai 0.0, tidak wajib diisi.
double hitungHargaSetelahDiskon({required double harga, double persenDiskon = 0.0}) {
  return harga - (harga * (persenDiskon / 100));
}

// 3. Versi arrow function dari fungsi sederhana
// Menggunakan tanda => untuk menyingkat penulisan kode yang hanya satu baris
String formatRupiah(double nominal) => 'Rp ${nominal.toStringAsFixed(0)}';

void main () {
double hargaBarang = 200000.0;

//parameter biasa
print('Parameter biasa:');
double totalBiasa = hitungHargaSetelahDiskonBiasa(hargaBarang, 10.0);
print('Harga awal 200rb, setelah diskon 10%: $totalBiasa\n');
  
//named parameter
// memanggil fungsi tanpa argumen diskon
print('Named parameter:');
double totalTanpaDiskon = hitungHargaSetelahDiskon(harga: hargaBarang);
print('Total harga barang tanpa argumen diskon: $totalTanpaDiskon');
// memanggil fungsi dengan argumen diskon
double totalDenganDiskon = hitungHargaSetelahDiskon(harga: hargaBarang, persenDiskon: 20.0);
print('Total harga barang dengan argumen diskon 20%: $totalDenganDiskon\n');

//arrow function
print('Arrow function:');
String hargaFormat = formatRupiah(hargaBarang);
print('Harga barang diformat: $hargaFormat');
print('Harga barang diformat dengan diskon 20%: ${formatRupiah(totalDenganDiskon)}\n');
}
