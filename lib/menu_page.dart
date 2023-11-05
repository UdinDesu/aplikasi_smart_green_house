import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAm7bGA-6VT41H3b_kMhFe-womEJfRTMgU",
      appId: "1:518456025074:android:c33fec0f36b490c8e6956b",
      messagingSenderId: "518456025074",
      projectId: "aplikasi-smart-green-house",
      storageBucket: "dht11",
      databaseURL: "https://aplikasi-smart-green-house-default-rtdb.firebaseio.com/",
    ),
  );
  runApp(MenuPageApp());
}

class MenuPageApp extends StatefulWidget {
  @override
  _MenuPageAppState createState() => _MenuPageAppState();
}

class _MenuPageAppState extends State<MenuPageApp> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  String firebaseData = "Loading...";

  @override
  void initState() {
    super.initState();
    DatabaseReference _firebaseRef = FirebaseDatabase.instance.reference();

    _firebaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final dynamic data = event.snapshot.value;
        setState(() {
          firebaseData = "Temp: ${data['temp'] ?? 0.0}, Humidity: ${data['humidity'] ?? 0.0}";
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
        child: Text(
          'Data dari Firebase: $firebaseData',
          style: TextStyle(fontSize: 18),
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
