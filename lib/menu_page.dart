import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'bottom_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
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
  double suhuRuangan = 0.0;
  double kelembapanRuangan = 0.0;
  int kelembapanTanah = 0;
  String statusRelay = 'OFF';
  bool isLed1On = true;

  final DatabaseReference led1Reference =
  FirebaseDatabase.instance.reference().child('Status_Lampu');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleLed1() {
    setState(() {
      isLed1On = !isLed1On;
    });

    led1Reference.set(isLed1On ? 'ON' : 'OFF');
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference _firebaseRef = FirebaseDatabase.instance.reference();

    _firebaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final dynamic data = event.snapshot.value;
        setState(() {
          suhuRuangan = (data['Suhu_ruangan'] as double?) ?? 0.0;
          kelembapanRuangan = (data['Kelembapan_ruangan'] as double?) ?? 0.0;
          kelembapanTanah = (data['Kelembapan_tanah'] as int?) ?? 0;
          statusRelay = data['Status_relay'] ?? 'OFF';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Kontrol Perangkat'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildDataItem('Suhu Ruangan', '$suhuRuangan °C'),
          buildDataItem('Kelembapan Ruangan', '$kelembapanRuangan %'),
          buildDataItem('Kelembapan Tanah', '$kelembapanTanah %'),
          buildDataItem('Status Relay', statusRelay),
          GestureDetector(
            onTap: _toggleLed1,
            child: Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: isLed1On ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isLed1On ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
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

  Widget buildDataItem(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
