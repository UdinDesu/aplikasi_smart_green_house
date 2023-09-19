import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // Membuat animasi berulang

    // Mengatur transisi dekorasi dari putih ke linear gradient
    _tween = DecorationTween(
      begin: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFFFFF), // Warna gradient pertama (putih)
            const Color(0xFFFFFFFF), // Warna gradient kedua (putih)
            const Color(0xFFFFFFFF), // Warna gradient ketiga (putih)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      end: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB0FF09), // Warna gradient pertama
            const Color(0xFFFFFFFF), // Warna gradient kedua
            const Color(0xFFB9ED4D), // Warna gradient ketiga
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );

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

        // Memulai transisi latar belakang
        _animationController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: null,
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            // Menggunakan tween untuk animasi dekorasi
            final decoration = _tween.animate(_animationController).value;
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: decoration, // Menggunakan dekorasi yang diatur oleh tween
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        final double rotationValue =
                            2 * 3.14159265359 * _animationController.value;
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(rotationValue),
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Smart Green House',
                      style: TextStyle(
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
