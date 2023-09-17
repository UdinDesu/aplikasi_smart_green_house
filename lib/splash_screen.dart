import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_page.dart';
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: null, // Menghilangkan header
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF09562B), // Warna gradient dari bawah hijau tua (#09562B)
            Color(0xFF3FAF65), // Warna gradient hingga ke atas hijau terang (#3FAF65)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/image/icon.png', // Sesuaikan dengan path ke gambar logo Anda
              width: 100, // Sesuaikan dengan lebar yang Anda inginkan
              height: 100, // Sesuaikan dengan tinggi yang Anda inginkan
            ),
            CircularProgressIndicator(), // Tampilkan indikator loading
            SizedBox(height: 20),
            Text(
              'Aplikasi sedang memuat...',
              style: TextStyle(
                color: Colors.white, // Ubah warna teks menjadi putih
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
