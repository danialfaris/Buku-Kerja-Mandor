import 'package:buku_kerja_mandor/models/activity_model.dart';
import 'package:buku_kerja_mandor/models/hasil_kerja_model.dart';
import 'package:buku_kerja_mandor/models/karyawan_model.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'bkm.dart';
import 'package:intl/intl.dart';
import 'models/activity_model.dart';
import 'models/panen_model.dart';

class LaporPanen extends StatefulWidget {
  final AktivitasPanen args;
  final Karyawan karyawan;
  LaporPanen(this.args, this.karyawan);

  @override
  State<LaporPanen> createState()=>_LaporPanen(args, karyawan);
}

class _LaporPanen extends State<LaporPanen> {
  final AktivitasPanen args;
  final Karyawan karyawan;
  _LaporPanen(this.args, this.karyawan);

  final _formKey = GlobalKey<FormState>();
  DatabaseService service = DatabaseService();
  TextEditingController _tahun = TextEditingController();
  TextEditingController _blok = TextEditingController();
  TextEditingController _jelajah = TextEditingController();
  TextEditingController _tdn = TextEditingController();
  TextEditingController _kg = TextEditingController();
  TextEditingController _krd = TextEditingController();
  TextEditingController _ml = TextEditingController();
  TextEditingController _p = TextEditingController();
  HasilKerja hasilKerja = HasilKerja();

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    List<HasilKerja> retrieved = await service.ambilHasilKerja(args.id!, karyawan.id);
    print(retrieved.length);
    hasilKerja = retrieved[0];
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lapor Hasil Kerja Individu",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 10,
        ),
        body: Container(
            height: 1200,
            width: double.maxFinite,
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  ListTile(
                    title:
                    Text('Nama',
                        style: TextStyle(color: Color(0xFF757575))),
                    subtitle:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text("${karyawan.nama}",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                      ],
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: 5),
                  Divider(thickness: 10),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                    child:
                    Text('Kode Blok', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _blok,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        ),
                        hintText: hasilKerja.blok == null ? 'Kode' : "${hasilKerja.blok}",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan kode blok.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child:
                    Text('Luas Jelajah', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _jelajah,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        ),
                        hintText: hasilKerja.luas == null ? 'Ha' : "${hasilKerja.luas}",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan luas jelajah yang dilakukan.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child:
                    Text('Tandan', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _tdn,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        ),
                        hintText: hasilKerja.tandan == null ? 'Kg' : "${hasilKerja.tandan}",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan jumlah tandan.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child:
                    Text('Berondong', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _krd,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        ),
                        hintText: hasilKerja.krd == null ? 'Kg' : "${hasilKerja.krd}",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan jumlah Berondong yang terkumpulkan.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child:
                    Text('Pikul', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _p,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        ),
                        hintText: hasilKerja.p == null ? 'Kg' : "${hasilKerja.p}",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan jumlah pikul yang dilakukan.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),

                  ListTile(
                    tileColor: Color(0xFFC8E6C9),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Laporkan', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                      ],
                    ),
                    onTap: () async {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        DatabaseService service = DatabaseService();
                        HasilKerja hasil = HasilKerja(
                          blok: _blok.text,
                          luas: int.parse(_jelajah.text),
                          tandan: int.parse(_tdn.text),
                          krd: int.parse(_krd.text),
                          p: int.parse(_p.text),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Memproses Data')),
                        );
                        await service.updateAktivitasPanen(args,karyawan.id,hasil);
                        Navigator.pop(context);
                      }
                  ),
                ],
              ),
            )
        )
    );
  }
}