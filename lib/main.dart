import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Warna tema pilihan: Maroon (sesuai warna almamater).
const Color kThemeColor = Color(0xFF800020);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kThemeColor),
        scaffoldBackgroundColor: const Color(0xFFF6F1F2),
      ),
      home: const ProductProfilePage(),
    );
  }
}

/// Halaman utama: banner promo, kartu profil, dan kartu produk.
class ProductProfilePage extends StatelessWidget {
  const ProductProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 64,
        title: const Text(
          'PPM Sesi 2 - Yokhanan Haposan Siregar (20240040211)',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PromoBanner(),
              const SizedBox(height: 16),
              const ProfileCard(
                nama: 'Yokhanan Haposan Siregar',
                nim: '20240040211',
                prodiKelas: 'Teknik Informatika / TI24D',
              ),
              const SizedBox(height: 16),
              Text(
                'Produk Pilihan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const ProductCard(
                name: 'Sepatu Sneakers Pria',
                category: 'Fashion',
                price: 350000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Banner promo sederhana menggunakan Stack dan Positioned.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF800020), Color(0xFFD4526E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Ikon dekoratif di sisi kanan bawah
          const Positioned(
            right: -10,
            bottom: -16,
            child: Icon(
              Icons.local_offer,
              size: 110,
              color: Color(0x2EFFFFFF),
            ),
          ),
          // Teks promo di kiri bawah
          const Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DISKON HINGGA 30%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Khusus mahasiswa - periode terbatas!',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          // Label "PROMO" di kanan atas
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'PROMO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kartu profil mahasiswa (StatelessWidget).
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodiKelas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Foto profil (fallback ke ikon bila aset tidak ditemukan)
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kThemeColor, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_circle,
                    size: 78,
                    color: kThemeColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.badge, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text('NIM: $nim'),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.school, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(child: Text(prodiKelas)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 5 ikon bintang
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu produk (StatefulWidget) dengan favorite, kuantitas, dan keranjang.
class ProductCard extends StatefulWidget {
  final String name;
  final String category;
  final int price;

  const ProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;
  int _likeCount = 24;
  int _quantity = 1;

  int get _totalPrice => widget.price * _quantity;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likeCount += _isFavorite ? 1 : -1;
    });
  }

  void _increment() {
    setState(() => _quantity++);
  }

  void _decrement() {
    // Jumlah minimal adalah 1
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: kThemeColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          '$_quantity x ${widget.name} ditambahkan ke keranjang '
          '(${formatRupiah(_totalPrice)})',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder gambar produk
          Container(
            height: 160,
            color: const Color(0xFFEBDDE0),
            alignment: Alignment.center,
            child: const Icon(
              Icons.directions_run,
              size: 80,
              color: kThemeColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Tombol Favorite + jumlah Like
                    InkWell(
                      onTap: _toggleFavorite,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          children: [
                            Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$_likeCount',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Chip(
                  label: Text(widget.category),
                  avatar: const Icon(Icons.category, size: 16),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(height: 6),
                Text(
                  formatRupiah(widget.price),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kThemeColor,
                  ),
                ),
                const Divider(height: 28),
                // Kontrol jumlah produk
                Row(
                  children: [
                    const Text(
                      'Jumlah',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    IconButton.outlined(
                      onPressed: _decrement,
                      icon: const Icon(Icons.remove),
                      tooltip: 'Kurangi',
                    ),
                    Container(
                      width: 48,
                      alignment: Alignment.center,
                      child: Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: _increment,
                      icon: const Icon(Icons.add),
                      tooltip: 'Tambah',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Harga', style: TextStyle(fontSize: 15)),
                    Text(
                      formatRupiah(_totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _addToCart,
                    style: FilledButton.styleFrom(
                      backgroundColor: kThemeColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Tambah ke Keranjang'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Format angka ke Rupiah, contoh: 350000 -> "Rp 350.000".
String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return 'Rp $buffer';
}
