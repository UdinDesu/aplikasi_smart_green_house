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
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DashboardPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              var fadeAnimation =
                  Tween(begin: begin, end: end).animate(animation);

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
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
              Color(0xFF74B557), // Warna gradient Atas
              Color(0xFFA6DD8E), // Warna gradient Bawah
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
                'images/logo.png', // Sesuaikan dengan path ke gambar Anda
                width: 100, // Sesuaikan dengan lebar yang Anda inginkan
                height: 100, // Sesuaikan dengan tinggi yang Anda inginkan
              ),
              const SizedBox(height: 20), // Beri jarak antara gambar dan teks
            ],
          ),
        ),
      ),
    );
  }
}
