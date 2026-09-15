void main () {

int stokProduk = 15;
double hargaProduk = 200000.0;
int jumlahBeli = 3;

// operator aritmatika
int sisaStok = stokProduk - jumlahBeli;
double totalHarga = hargaProduk * jumlahBeli;


print('Operator Aritmatika:');
print('Jumlah barang dibeli : $jumlahBeli');
print('Sisa stok barang : $sisaStok');  
print('Total harga barang : $totalHarga');


// operator perbandingan
print('\nOperator Perbandingan:');
bool isStokAman = stokProduk >= 10;
bool isHargaMahal = hargaProduk > 1000000;
bool isHabis = sisaStok == 0;

print('Apakah stok aman? : $isStokAman');
print('Apakah harga mahal? : $isHargaMahal');
print('Apakah barang habis? : $isHabis');

// operator logika
print('\nOperator Logika:');
bool isDiskon = (jumlahBeli > 2) && (totalHarga > 500000);
bool layakTampil = (sisaStok > 0) || (hargaProduk > 0);
bool masihAda = !isHabis;

print('Apakah barang mendapatkan diskon? : $isDiskon');
print('Apakah barang layak ditampilkan? : $layakTampil');
print('Apakah masih ada barang? : $masihAda');

}