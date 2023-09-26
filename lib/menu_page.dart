import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'add_menu.dart';

void main() {
  runApp(MenuPageApp());
}

class MenuPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
      routes: {
        '/add_menu': (context) => AddMenuApp(),
      },
      onUnknownRoute: (settings) {
        // Mengembalikan halaman NotFoundPage jika rute tidak dikenali
        return MaterialPageRoute(
          builder: (context) => NotFoundPage(),
        );
      },
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Menu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => DashboardApp(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0); // Geser dari kanan ke kiri
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'add',
                  child: Text('Add'),
                ),
                PopupMenuItem<String>(
                  value: 'select',
                  child: Text('Select'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'add') {
                Navigator.pushNamed(context, '/add_menu');
              } else if (value == 'select') {
                // Tambahkan logika untuk tindakan "Select" di sini
              }
            },
          ),
        ],
      ),
      body: Container(), // Tambahkan konten Anda di sini
    );
  }
}

// Halaman NotFoundPage untuk menangani rute yang tidak dikenali
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Halaman tidak ditemukan.'),
      ),
    );
  }
}
