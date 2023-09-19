import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Page'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // Menyusun 2 kolom
          mainAxisSpacing: 20.0, // Jarak vertikal antar item
          crossAxisSpacing: 20.0, // Jarak horizontal antar item
          padding: EdgeInsets.all(20.0), // Padding keseluruhan GridView
          children: <Widget>[
            _buildMenuItem(context, 'Pilihan 1', Icons.access_alarm),
            _buildMenuItem(context, 'Pilihan 2', Icons.accessibility),
            _buildMenuItem(context, 'Pilihan 3', Icons.airplanemode_active),
            _buildMenuItem(context, 'Pilihan 4', Icons.access_alarm),
            _buildMenuItem(context, 'Pilihan 5', Icons.accessibility),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Tambahkan aksi yang sesuai ketika item dipilih
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green, // Warna latar belakang kotak
          borderRadius: BorderRadius.circular(10.0), // Bentuk border kotak
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 40.0, // Ukuran ikon
              color: Colors.white, // Warna ikon
            ),
            SizedBox(height: 10.0), // Jarak antara ikon dan teks
            Text(
              title,
              style: TextStyle(
                color: Colors.white, // Warna teks
                fontSize: 18.0, // Ukuran teks
                fontWeight: FontWeight.bold, // Ketebalan teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
