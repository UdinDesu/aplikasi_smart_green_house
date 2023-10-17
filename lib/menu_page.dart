import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'add_menu.dart';
import 'bottom_nav_bar.dart'; // Import file bottom_nav_bar.dart

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
                // Handle Select action
              }
            },
          ),
        ],
      ),
      body: Container(), // Tambahkan konten menu di sini
      bottomNavigationBar: CustomBottomNavigationBar( // Tambahkan bottom navigation bar
        currentIndex: 1, // Index 1 sesuai dengan Menu
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DashboardApp(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
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
          } else if (index == 2) {
            // Handle Settings
          }
        },
      ),
    );
  }
}

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
