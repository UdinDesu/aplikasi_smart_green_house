import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'splash_screen.dart';
import 'dashboard_page.dart';
import 'menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inisialisasi Firebase dengan FirebaseOptions
    Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAm7bGA-6VT41H3b_kMhFe-womEJfRTMgU",
        appId: "1:518456025074:android:c33fec0f36b490c8e6956b",
        messagingSenderId: "518456025074",
        projectId: "aplikasi-smart-green-house",
        storageBucket: "dht11",
        databaseURL: "https://aplikasi-smart-green-house-default-rtdb.firebaseio.com/",
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      // Rute-rute aplikasi didefinisikan di sini
      routes: {
        '/': (context) => SplashScreen(), // Rute halaman utama
        '/dashboard': (context) => DashboardPage(), // Rute dashboard
        '/menu': (context) => MenuPageApp(), // Rute menu
      },
      initialRoute: '/', // Rute awal saat aplikasi dimulai
    );
  }
}
