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
    ),
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
  TimeOfDay lampuHidup = TimeOfDay.now();
  TimeOfDay lampuMati = TimeOfDay.now();

  DatabaseReference? _firebaseSensorRef;
  DatabaseReference? _firebaseRelayRef;
  bool _isDisposed = false;

  final DatabaseReference led1Reference = FirebaseDatabase.instance.reference().child('Status').child('Lampu');

  void _updateSensorData(dynamic data) {
    setState(() {
      suhuRuangan = (data['Suhu_ruangan'] as num?)?.toDouble() ?? 0.0;
      kelembapanRuangan = (data['Kelembapan_ruangan'] as num?)?.toDouble() ?? 0.0;
      kelembapanTanah = (data['Kelembapan_tanah'] as num?)?.toInt() ?? 0;
    });
  }

  void _updateRelayStatus(dynamic data) {
    setState(() {
      // Menggunakan DatabaseReference terpisah untuk relay
      statusRelay = (data['Relay'] as String?) ?? 'OFF';
    });
  }

  @override
  void initState() {
    super.initState();

    // DatabaseReference untuk sensor
    _firebaseSensorRef = FirebaseDatabase.instance.reference().child('Sensor');
    // DatabaseReference terpisah untuk relay
    _firebaseRelayRef = FirebaseDatabase.instance.reference().child('Status');

    _firebaseSensorRef?.onValue.listen((event) {
      if (!_isDisposed) {
        if (event.snapshot.value != null) {
          final dynamic data = event.snapshot.value;

          // Memanggil metode terpisah untuk memproses sensor
          _updateSensorData(data);
        }
      }
    });

    _firebaseRelayRef?.onValue.listen((event) {
      if (!_isDisposed) {
        if (event.snapshot.value != null) {
          final dynamic data = event.snapshot.value;

          // Memanggil metode terpisah untuk memproses relay
          _updateRelayStatus(data);
        }
      }
    });
  }



  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

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

  void _sendTimeData() {
    try {
      // Mengambil nilai jam dan menit untuk kedua lampu
      int jamHidup = lampuHidup.hour;
      int menitHidup = lampuHidup.minute;

      int jamMati = lampuMati.hour;
      int menitMati = lampuMati.minute;

      // Kirim data ke Firebase
      FirebaseDatabase.instance.reference().child('Waktu').set({
        'JamHidup': jamHidup,
        'MenitHidup': menitHidup,
        'JamMati': jamMati,
        'MenitMati': menitMati,
      });
    } catch (error) {
      print("Error sending time data: $error");
      // Handle error accordingly, e.g., show an error message
    }
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
          buildDataItem('Kelembapan Tanah', '$kelembapanTanah'),
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
                    color: isLed1On ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
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
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: lampuHidup,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        lampuHidup = selectedTime;
                      });
                    }
                  },
                  child: IgnorePointer(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Jam Lampu Hidup',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: lampuHidup.format(context),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: lampuMati,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        lampuMati = selectedTime;
                      });
                    }
                  },
                  child: IgnorePointer(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Jam Lampu Mati',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: lampuMati.format(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _sendTimeData,
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Warna latar belakang tombol
              elevation: 5,
              // Spread Radius, Blur Radius, dan Offset juga dapat diatur sesuai kebutuhan
              shadowColor: Colors.green.withOpacity(0.5),
            ).copyWith(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.green;
                },
              ),
              elevation: MaterialStateProperty.resolveWith<double?>((_) => 5),
              // Spread Radius, Blur Radius, dan Offset juga dapat diatur sesuai kebutuhan
              shadowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.green.withOpacity(0.5);
                },
              ),
            ),
            child: Text(
              'Kirim Waktu ke Firebase',
              style: TextStyle(color: Colors.white), // Warna teks tombol
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
