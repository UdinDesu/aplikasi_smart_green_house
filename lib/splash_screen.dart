import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_page.dart'; // Pastikan impor telah sesuai dengan struktur direktori Anda

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Mengubah waktu menjadi 3 detik
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => DashboardPage(),
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
}
