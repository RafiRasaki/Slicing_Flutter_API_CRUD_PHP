import 'package:appsproduk/pages/halaman_produk.dart';
import 'package:appsproduk/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Produk',
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => SplashScreen(),
        '/home' :(context) => HalamanProduk()
      },
    );
  }
}

