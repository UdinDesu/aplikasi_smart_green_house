import 'package:flutter/material.dart';

void main() {
  runApp(MenuPageApp());
}

class MenuPageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height, // Menggunakan tinggi layar yang tersedia
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF9DEBB2), Color(0xFFB6EB9D), Color(0xFF83B51A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.0, // Sesuaikan posisi horizontal tombol kembali
            top: 40.0, // Sesuaikan posisi vertikal tombol kembali
            child: Material(
              // Tambahkan Material di sekitar IconButton
              type: MaterialType.transparency,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
              ),
            ),
          ),
          Container(
            width: 466,
            height: 336,
            child: Stack(
              children: [
                Positioned(
                  left: 68,
                  top: 0,
                  child: Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: 398,
                      height: 222,
                      decoration: ShapeDecoration(
                        color: Color(0xFF222042),
                        shape: StadiumBorder(), // Menggunakan StadiumBorder untuk bentuk oval
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 33,
                  top: 70,
                  child: Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: 398,
                      height: 222,
                      decoration: ShapeDecoration(
                        color: Color(0xFF222042),
                        shape: StadiumBorder(), // Menggunakan StadiumBorder untuk bentuk oval
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 114,
                  child: Opacity(
                    opacity: 0.02,
                    child: Container(
                      width: 398,
                      height: 222,
                      decoration: ShapeDecoration(
                        color: Color(0xFF222042),
                        shape: StadiumBorder(), // Menggunakan StadiumBorder untuk bentuk oval
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 466,
            height: 336,
            child: Stack(
              children: [
                Positioned(
                  left: 68,
                  top: 400, // Sesuaikan posisi vertikal ke kiri bawah
                  child: Opacity(
                    opacity: 0.10,
                    child: Container(
                      width: 398,
                      height: 222,
                      decoration: ShapeDecoration(
                        color: Color(0xFF222042),
                        shape: StadiumBorder(), // Menggunakan StadiumBorder untuk bentuk oval
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ... Widget lainnya ...
        ],
      ),
    );
  }
}
