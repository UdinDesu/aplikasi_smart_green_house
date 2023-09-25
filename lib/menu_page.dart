import 'package:flutter/material.dart';
import 'dashboard_page.dart';

void main() {
  runApp(MenuPageApp());
}

class MenuPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DashboardApp(),
              ),
            );
          },
        ),
        actions: <Widget>[
        ],
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menuItems[index]),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                print('Pilihan yang dipilih: $value');
              },
              itemBuilder: (context) {
                return menuItems.map((item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          );
        },
      ),
    );
  }
}
