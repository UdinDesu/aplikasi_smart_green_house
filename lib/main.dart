import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'dashboard_page.dart';
import 'menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/dashboard': (context) => DashboardPage(),
        '/menu': (context) => MenuPageApp(),
      },
      initialRoute: '/',
    );
  }
}
