import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'menu_page.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final List<String> images = [
    'assets/images/banner1.png',
    'assets/image2.jpg',
    'assets/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MenuPageApp(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: images.map((image) {
              return Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity, // Mengisi ruang vertikal
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enlargeCenterPage: true,
              viewportFraction: 1.0, // Mengisi seluruh lebar
              aspectRatio: 16 / 9,
            ),
          ),
          Container(
            color: const Color(0xFF1E420D),
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: Text(
              'Informasi Kontrol Aplikasi',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  // Tambahkan widget di sini (kotak tampilan)
                  BuildInfoBox("Suhu Ruangan", 'assets/icon/temp.png', context),
                  BuildInfoBox(
                      "Intensitas Cahaya", 'assets/icon/light.png', context),
                  BuildInfoBox("Kelembapan", 'assets/icon/soil.png', context),
                  BuildInfoBox("Kadar Air", 'assets/icon/water.png', context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat kotak tampilan informasi yang dapat ditekan
  Widget BuildInfoBox(String title, String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    imagePath,
                    width: 80.0,
                    height: 80.0,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Detail informasi di sini...",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tutup'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
