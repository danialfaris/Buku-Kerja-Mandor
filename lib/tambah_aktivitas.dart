import 'dart:async';
import 'package:intl/intl.dart';

import 'package:buku_kerja_mandor/models/activity_model.dart';
import 'package:buku_kerja_mandor/models/validation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'services/database_service.dart';

class TambahAktivitas extends StatefulWidget{
  const TambahAktivitas({Key? key}) : super(key: key);
  @override
  _TambahAktivitas createState() => _TambahAktivitas();
}

class _TambahAktivitas extends State<TambahAktivitas> {
  final _formKey = GlobalKey<FormState>();
  FormProvider? _formProvider;
  String dropdownValue= 'Pilih Aktivitas';
  TextEditingController dateinput = TextEditingController();

  void initState(){
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FormProvider> (context);
    TextEditingController _Kode = TextEditingController();
    TextEditingController _Sektor = TextEditingController();
    TextEditingController _Blok = TextEditingController();
    TextEditingController _Target = TextEditingController();

    const ctext = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

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
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      items: <String>[
                        'Pilih Aktivitas',
                        'Pembabatan',
                        'Pembuatan Tangga Panen',
                        'Pemeliharaan Jalan',
                        'Pemeliharaan Saluran Air',
                        'Pemupukan',
                        'Penunasan',
                        'Penyemprotan',
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
                    ),

                    TextField(
                      controller: dateinput, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2030)
                        );

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                    ),

                    const SizedBox(height: 10.0),
                    const Text('Kode', style: ctext),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _Kode,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Kode';
                        }
                        return null;
                      },
                    ),
                    Divider(),

                    const SizedBox(height: 10.0),
                    const Text('Sektor', style: ctext),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _Sektor,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Sektor';
                        }
                        return null;
                      },
                    ),
                    Divider(),

                    const SizedBox(height: 10.0),
                    const Text('Blok', style: ctext),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _Blok,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Blok';
                        }
                        return null;
                      },
                    ),
                    Divider(),

                    const SizedBox(height: 10.0),
                    const Text('Target', style: ctext),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _Target,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan Target';
                        }
                        return null;
                      },
                    ),
                    Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          print(dateinput.text);
                          if (_formKey.currentState!.validate() && dropdownValue != "Pilih Aktivitas") {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            DatabaseService service = DatabaseService();
                            Aktivitas aktivitas = Aktivitas(
                                tanggal: dateinput.text,
                                jenis: dropdownValue,
                                kode: _Kode.text,
                                sektor: _Sektor.text,
                                blok: _Blok.text,
                                target: int.parse(_Target.text)
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Memproses Data')),
                            );
                            await service.tambahAktivitas(aktivitas);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Tambah'),
                      ),
                    ),
                  ],
                )
              ),
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