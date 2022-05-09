import 'dart:async';

import 'package:buku_kerja_mandor/models/validation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TambahAktivitas extends StatefulWidget{
  const TambahAktivitas({Key? key}) : super(key: key);
  @override
  _TambahAktivitas createState() => _TambahAktivitas();
}

class _TambahAktivitas extends State<TambahAktivitas> {
  final _formKey = GlobalKey<FormState>();
  FormProvider? _formProvider;

  Future tambahAktivitas({required String test}) async {
    final testing = FirebaseFirestore.instance.collection('test').doc('more-test');

    final json = {
      'test': test,
    };

    await testing.set(json);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FormProvider> (context);
    TextEditingController _Kode = TextEditingController();
    TextEditingController _Nama = TextEditingController();
    TextEditingController _Sektor = TextEditingController();
    TextEditingController _Blok = TextEditingController();
    TextEditingController _Bahan = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Aktivitas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(10),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropDownWidget(),
                    ListTile(
                      title: Text("Blok",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      subtitle:
                      TextField(
                        controller: _Blok,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                        ),
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            tambahAktivitas(test: _Blok.text );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                )
              ),
              ListTile(
                title: Text("test",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                subtitle:
                TextField(
                  controller: _Kode,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                  ),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                  onPressed: (){
                    final test = _Kode.text;

                    tambahAktivitas(test: test);
                  },
                  icon: Icon(Icons.add),
              )
              /**
              TextFieldClass('Kode',_Kode),
              SizedBox(height: 10),
              TextFieldClass('Nama',_Nama),
              SizedBox(height: 10),
              TextFieldClass('Sektor',_Sektor),
              SizedBox(height: 10),
              TextFieldClass('Blok',_Blok),
              SizedBox(height: 10),
              TextFieldClass('Bahan',_Bahan),
              SizedBox(height: 10),
               **/
            ]
        ),
      ),
    );
  }

}

class TextFieldClass extends StatelessWidget{
  TextFieldClass(this.title,this.cname);
  final String title;
  TextEditingController cname;

  @override
  Widget build(BuildContext context) {
    cname = TextEditingController();
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
      subtitle:
      TextField(
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
        ),
        decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}


class DropDownWidget extends StatefulWidget{
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget>{
  String dropdownValue = 'Pilih Aktivitas';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        items: <String>[
          'Pilih Aktivitas',
          'Penyemprotan',
          'Pembabatan',
          'Pemeliharaan Jalan',
          'Pemeliharaan Saluran Air',
          'Pembuatan Tangga Panen',
          'Penunasan',
        ].map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            dropdownValue = newValue!;
          });
        },
    );
  }
}

class FormProvider with ChangeNotifier{
  ValidationModel _jenis = ValidationModel(null, null);
  ValidationModel _kode = ValidationModel(null, null);
  ValidationModel _sektor = ValidationModel(null, null);
  ValidationModel _blok = ValidationModel(null, null);
  ValidationModel get jenis => _jenis;
  ValidationModel get kode => _kode;
  ValidationModel get sektor => _sektor;
  ValidationModel get blok => _blok;

  void validateJenis(String? val){
    if (val != null){
      _jenis = ValidationModel(val, null);
    } else{
      _jenis = ValidationModel(null, 'Pilih Jenis Aktivitas');
    }
    notifyListeners();
  }
  void validateKode(String? val){
    if (val != null){
      _kode = ValidationModel(val, null);
    } else{
      _kode = ValidationModel(null, 'Masukkan Kode Aktivitas');
    }
    notifyListeners();
  }
  void validateSektor(String? val){
    if (val != null){
      _sektor = ValidationModel(val, null);
    } else{
      _sektor = ValidationModel(null, 'Masukkan Sektor');
    }
    notifyListeners();
  }
  void validateBlok(String? val){
    if (val != null){
      _blok = ValidationModel(val, null);
    } else{
      _blok = ValidationModel(null, 'Masukkan Blok');
    }
    notifyListeners();
  }
  bool get validate{
    return
      _jenis.value != null &&
          _kode.value != null &&
          _sektor.value != null &&
          _blok.value != null;
  }
}