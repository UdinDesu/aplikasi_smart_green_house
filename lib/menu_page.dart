import 'package:flutter/material.dart';

void main() {
  runApp(const MenuPageApp());
}

class MenuPageApp extends StatelessWidget {
  const MenuPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MenuPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context)
          .size
          .height, // Menggunakan tinggi layar yang tersedia
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF9DEBB2), Color(0xFFB6EB9D), Color(0xFF83B51A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.0, // Sesuaikan posisi horizontal tombol kembali
            top: 40.0, // Sesuaikan posisi vertikal tombol kembali
            child: Material(
              // Tambahkan Material di sekitar IconButton
              type: MaterialType.transparency,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
              ),
            ),
          ),
          // ... Widget lainnya ...
        ],
      ),
    );
  }
}
