import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
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
          // Navigasi ke halaman 'SettingsPage'
            Navigator.pushReplacementNamed(context, '/settings');
            break;
        }
      },
    );
  }
}
