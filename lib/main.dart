import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
        apiKey: 'AIzaSyAsflovMFBOYAI4dIKk7SWhKprlkN_ArNY',
        appId: '1:518456025074:web:d68350e7112da44ee6956b',
        messagingSenderId: '518456025074',
        projectId: 'aplikasi-smart-green-house',
        authDomain: 'aplikasi-smart-green-house.firebaseapp.com',
        databaseURL: 'https://aplikasi-smart-green-house-default-rtdb.firebaseio.com',
        storageBucket: 'aplikasi-smart-green-house.appspot.com',
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