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
              aspectRatio: 15 / 7,
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
                childAspectRatio: 1.0, // Adjust the aspect ratio as needed
                children: [
                  BuildInfoBox(
                    "Suhu Ruangan",
                    'assets/icon/temp.png',
                    context,
                    Colors.black,
                    "Suhu akan ditampilkan dalam satuan Celsius, suhu ini mencakup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Intensitas Cahaya",
                    'assets/icon/light.png',
                    context,
                    Colors.black,
                    "Intensitas Cahaya ditampilkan dalam satuan persen, Intensitas Cahaya ini mencakup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Kelembapan",
                    'assets/icon/soil.png',
                    context,
                    Colors.black,
                    "Kelembapan ditampilkan dalam satuan persen, Kelembapan ini mencakup 1 ruangan",
                    Colors.white,
                  ),
                  BuildInfoBox(
                    "Kadar Air",
                    'assets/icon/water.png',
                    context,
                    Colors.black,
                    "Kadar air ditampilkan dalam satuan persen, Kadar air ini mencakup tanah yang berada di ruangan tersebut",
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
                    width: 50.0, // Set the width of the image to 50 px
                    height: 50.0, // Set the height of the image to 50 px
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
                width: 50.0, // Set the width of the image to 50 px
                height: 50.0, // Set the height of the image to 50 px
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
}
