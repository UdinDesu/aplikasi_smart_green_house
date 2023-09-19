import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_page.dart';
/*import 'package:transform_matrix/transform_matrix.dart';*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Membuat animasi berulang

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
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan "Debug"
      theme: ThemeData.dark(), // Menghilangkan pengaturan scaffoldBackgroundColor
      home: Scaffold(
        appBar: null, // Menghilangkan header
        body: Container(
          width: double.infinity, // Lebar container mengisi seluruh lebar layar
          height: double.infinity, // Tinggi container mengisi seluruh tinggi layar
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF84B51A), // Warna pertama
                const Color(0xFFB6EB9D), // Warna kedua
                const Color(0xFF9DEBB3), // Warna ketiga
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final transformationMatrix = Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspektif efek
                      ..rotateY(2 * 3.14159265359 * _animationController.value); // Putaran 3D

                    return Transform(
                      transform: transformationMatrix,
                      alignment: FractionalOffset.center,
                      child: Image.asset(
                        'assets/images/logo.png', // Sesuaikan dengan path ke gambar Anda
                        width: 100, // Sesuaikan dengan lebar yang Anda inginkan
                        height: 100, // Sesuaikan dengan tinggi yang Anda inginkan
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20), // Beri jarak antara gambar dan teks
                Text(
                  'Selamat datang di Aplikasi',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Jangan lupa membuang controller saat tidak digunakan
    super.dispose();
  }
}
