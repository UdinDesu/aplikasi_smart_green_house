import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1E420D),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Kontrol',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      onTap: (index) {
        switch (index) {
          case 0:
          // Navigasi ke halaman 'DashboardPage'
            Navigator.pushReplacementNamed(context, '/dashboard');
            break;
          case 1:
          // Navigasi ke halaman 'MenuPage'
            Navigator.pushReplacementNamed(context, '/menu');
            break;
          case 2:
        }
      },
    );
  }
}