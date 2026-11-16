import 'package:flutter_test/flutter_test.dart';
import 'package:ppm_sesi2/main.dart';

void main() {
  testWidgets('menampilkan AppBar dan tombol keranjang', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('PPM Sesi 2'), findsOneWidget);
    expect(find.text('Tambah ke Keranjang'), findsOneWidget);
  });
}