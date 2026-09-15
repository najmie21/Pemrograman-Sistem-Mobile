void main () {
  //control flow
  int stokBarang= 15;
  String statusProduk;

// percabangan if else untuk menentukan label status produk berdasarkan stok
  if(stokBarang > 10){
    statusProduk = 'tersedia';
  } else if (stokBarang > 0 && stokBarang <= 10){
    statusProduk = 'Stok Terbatas';
  } else {
    statusProduk = 'Habis';
  }
  print('if else:');
  print('stok saat ini: $stokBarang dengan status: $statusProduk\n');

  //perulangan for untuk menjumlahkan total harga dari List
  List<double> keranjangBelanja = [150000, 50000, 200000];
  double totalBelanja = 0;

  for (double harga in keranjangBelanja){
    totalBelanja += harga;
  }
  print('perulangan for:');
  print('daftar harga barang di keranjang belanja: $keranjangBelanja');
  print('total belanja: Rp $totalBelanja\n');  


  //perulangan while untuk simulasi pengurangan stok
  print('perulangan while:');
  int stokGudang = 4;
  while (stokGudang > 0){
    stokGudang--;
    print('-1 barang terjual. Sisa stok sekarang : $stokGudang');
  }
  print('stok habis, segera lakukan restock barang\n');

  //switch case menentukan besaran diskon berdasarkan kategori
  String kategoriBarang = 'Fashion';
  int diskonPersen = 0;

  switch (kategoriBarang){
    case 'Elektronik':
      diskonPersen = 10;
      break;
    case 'Fashion':
      diskonPersen = 15;
      break;
    case 'Makanan':
      diskonPersen = 5;
      break;
    default:
      diskonPersen = 0;
  }
  print('switch case:');
  print('Kategori barang: $kategoriBarang');
  print('Diskon yang diberikan: $diskonPersen%');
}
