import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), // Mengubah waktu menjadi 3 detik
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) =>DashboardPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Menghilangkan header
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
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
                'assets/images/logo.png', // Sesuaikan dengan path ke gambar logo Anda
                width: 100, // Sesuaikan dengan lebar yang Anda inginkan
                height: 100, // Sesuaikan dengan tinggi yang Anda inginkan
              ),
              const CircularProgressIndicator(), // Tampilkan indikator loading
              const SizedBox(height: 20),
              const Text(
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
}
