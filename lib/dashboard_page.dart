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
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Dashboard'),
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
                height: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
            ),
          ),
          Container(
            color: const Color(0xFF1E420D),
            padding: EdgeInsets.all(12.0),
            width: double.infinity,
            child: Text(
              'INFORMASI KONTROL APLIKASI',
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Coolvectica',
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 13.0,
                mainAxisSpacing: 13.0,
                children: [
                  BuildInfoBox(
                    "Suhu Ruangan",
                    'assets/icon/temp.png',
                    context,
                    Colors.black,
                    "Suhu akan di tunjukan dalam satuan Celsius, suhu ini mencangkup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Intensitas Cahaya",
                    'assets/icon/light.png',
                    context,
                    Colors.black,
                    "Intensitas Cahaya di tunjukan dalam satuan persen, Intensitas Cahaya ini mencangkup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Kelembapan",
                    'assets/icon/soil.png',
                    context,
                    Colors.black,
                    "Kelembapan di tunjukan dalam satuan persen, Kelembapan ini mencangkup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Kadar Air",
                    'assets/icon/water.png',
                    context,
                    Colors.black,
                    "Kadar air di tunjukkan dalam satuan persen, Kadar air ini mencangkup tanah yang berada di ruangan tersebut ",
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildInfoBox(
      String title,
      String imagePath,
      BuildContext context,
      Color textColor,
      String detailInfo,
      Color backgroundColor,
      ) {
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      detailInfo,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black, // Ganti warna teks sesuai kebutuhan
                      ),
                      textAlign: TextAlign.justify, // Mengatur rata kiri
                    ),
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
              backgroundColor: backgroundColor, // Mengatur warna latar belakang
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // Mengatur warna latar belakang
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
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.left, // Mengatur rata kiri
            ),
          ],
        ),
      ),
    );
  }
}
