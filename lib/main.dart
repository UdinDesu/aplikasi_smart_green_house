import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Pastikan mengimpor file yang sesuai

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Maenghilangkan teks "Debug"
      home: SplashScreen(), // Gunakan SplashScreen sebagai halaman awal
    );
  }
}
