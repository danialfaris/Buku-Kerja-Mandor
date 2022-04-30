import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TambahAktivitas extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Future tambahAktivitas({required String test}) async {
    final testing = FirebaseFirestore.instance.collection('test').doc('more-test');

    final json = {
      'test': test,
    };

    await testing.set(json);
  }

  @override
  Widget build(BuildContext context) {
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
                      title: Text("test",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      subtitle:
                      TextFormField(
                        controller: _Bahan,
                        validator: (test){
                          if (test == null || test.isEmpty){
                            return 'Please enter some text';
                          }
                        },
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
                            tambahAktivitas(test: _Bahan.text );
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