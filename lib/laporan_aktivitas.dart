import 'package:buku_kerja_mandor/models/activity_model.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'bkm.dart';
import 'package:intl/intl.dart';
import 'models/activity_model.dart';

class LaporAktivitas extends StatelessWidget {
  LaporAktivitas({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');
  TextEditingController _realisasi = TextEditingController();
  TextEditingController _liter = TextEditingController();
  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Aktivitas;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aktivitas",
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
                Text('Kode',
                    style: TextStyle(color: Color(0xFF757575))),
                subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text("${args.kode} - ${args.jenis}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                onTap: () {
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              ListTile(
                title:
                Text('Sektor',
                    style: TextStyle(color: Color(0xFF757575))),
                subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(args.sektor,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                onTap: () {
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              ListTile(
                title:
                Text('Blok',
                    style: TextStyle(color: Color(0xFF757575))),
                subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(args.blok,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                onTap: () {
                },
              ),
              ListTile(
                title:
                Text('Target Ha',
                    style: TextStyle(color: Color(0xFF757575))),
                subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text("${args.target.toDouble()} Ha",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                onTap: () {
                },
              ),
              SizedBox(height: 5),
              Divider(thickness: 10),
              ListTile(
                title: Row(
                  children: [
                    Text('Realisasi ha', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _realisasi,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                  ),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    ),
                    hintText: args.realisasi == null ? 'Ha' : "${args.realisasi}",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan jumlah Ha yang terealisasikan.';
                    }
                    return null;
                  },
                ),
              ),

              args.jenis == "Penyemprotan" ?
              ListTile(
                title: Row(
                  children: [
                    Text('Pemakaian', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ):SizedBox(),
              args.jenis == "Penyemprotan" ?
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 150, left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _liter,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                  ),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    ),
                    hintText: args.liter == null ? 'Liter' : "${args.liter}",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan jumlah liter yang digunakan';
                    }
                    return null;
                  },
                ),
              ):SizedBox(),

              SizedBox(height: 15),
              ListTile(
                tileColor: Color(0xFFC8E6C9),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Laporkan', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                onTap: () async {
                  print(_realisasi.text);
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    DatabaseService service = DatabaseService();
                    Aktivitas aktivitas = Aktivitas(
                        tanggal: args.tanggal,
                        jenis: args.jenis,
                        kode: args.kode,
                        sektor: args.sektor,
                        blok: args.blok,
                        target: args.target,
                        realisasi: int.parse(_realisasi.text),
                        liter: args.jenis == "Penyemprotan" ? int.parse(_liter.text) : args.liter,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Memproses Data')),
                    );
                    await service.updateAktivitas(aktivitas);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        )
      )
    );
  }
}

/**
class PrestasiKerja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prestasi Kerja Anggota",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text('19990511 - Suwardi', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 200, left: 20),
                child: TextField(
                  controller: TextEditingController(),
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black
                  ),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    ),
                    hintText: 'ha',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              ListTile(
                tileColor: Color(0xFFC8E6C9),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Input Prestasi Kerja Anggota', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),

                onTap: () {
                },
              ),

            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BKM()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}**/