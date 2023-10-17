import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(AddMenuApp());
}

class AddMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddMenu(),
    );
  }
}

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _namaTanamanController = TextEditingController();
  TextEditingController _codeAPIController = TextEditingController();
  TextEditingController _jumlahTanamController = TextEditingController();

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E420D),
        title: Text('Add Menu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MenuPage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: getImage,
              child: _image == null
                  ? Text('Pilih Gambar')
                  : Image.file(_image!),
            ),
            TextField(
              controller: _namaTanamanController,
              decoration: InputDecoration(labelText: 'Nama Tanaman'),
            ),
            TextField(
              controller: _codeAPIController,
              decoration: InputDecoration(labelText: 'Code API'),
            ),
            TextField(
              controller: _jumlahTanamController,
              decoration: InputDecoration(labelText: 'Jumlah Tanam'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lakukan sesuatu dengan data yang dimasukkan
                String namaTanaman = _namaTanamanController.text;
                String codeAPI = _codeAPIController.text;
                String jumlahTanam = _jumlahTanamController.text;
                print('Nama Tanaman: $namaTanaman');
                print('Code API: $codeAPI');
                print('Jumlah Tanam: $jumlahTanam');
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
