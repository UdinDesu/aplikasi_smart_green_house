import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'bottom_nav_bar.dart';

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

class DashboardPage extends StatefulWidget {
  final List<String> images = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double bottomNavBarHeight = kBottomNavigationBarHeight;
    double screenHeight = MediaQuery.of(context).size.height - bottomNavBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: widget.images.map((image) {
              return Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenHeight * 0.5, // 50% of available height
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
              padding: EdgeInsets.all(15.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8, // 80% of cell height
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
                    "Kadar air di tunjukkan dalam satuan persen, Kadar air ini mencangkup tanah yang berada di ruangan tersebut",
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
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
              backgroundColor: backgroundColor,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
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
                      width: 50.0, // Mengatur lebar gambar menjadi 50 px
                      height: 50.0, // Mengatur tinggi gambar menjadi 50 px
                    ),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        detailInfo,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
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
                backgroundColor: backgroundColor,
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
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
                padding: EdgeInsets.all(10.0),
                child: Image.asset(
                  imagePath,
                  width: 50.0, // Mengatur lebar gambar menjadi 50 px
                  height: 50.0, // Mengatur tinggi gambar menjadi 50 px
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      );
    }