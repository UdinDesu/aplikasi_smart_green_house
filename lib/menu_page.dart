import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:firebase_database/firebase_database.dart';

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
      )
  );
  runApp(MenuPageApp());
}

class MenuPageApp extends StatefulWidget {
  @override
  _MenuPageAppState createState() => _MenuPageAppState();
}

class _MenuPageAppState extends State<MenuPageApp> {
  int _selectedIndex = 0;
  double temp = 0.0;
  double hum = 0.0;

  @override
  void initState() {
    super.initState();
    DatabaseReference _firebaseRef = FirebaseDatabase.instance.reference();

    _firebaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final dynamic data = event.snapshot.value;
        setState(() {
          temp = (data['Suhu'] as double?) ?? 0.0;
          hum = (data['Kelembaban'] as double?) ?? 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Kontrol Perangkat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Suhu: $temp °C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            SizedBox(height: 16), // Menambahkan jarak vertikal
            Text(
              'Kelembaban: $hum %',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
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