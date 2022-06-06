import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'laporan_aktivitas.dart';
import 'package:intl/intl.dart';

import 'models/activity_model.dart';
import 'models/karyawan_model.dart';

class LihatAktivitasPemel extends StatelessWidget {
  LihatAktivitasPemel({Key? key}) : super(key: key);
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');
  static const routeName = '/view';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Aktivitas;
    return MaterialApp(
      theme: ThemeData(primarySwatch: myColor),
      home: DefaultTabController(
        length: args.jenis == "Penyemprotan" ? 3 : 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Aktivitas"),
                if (args.jenis == "Penyemprotan") Tab(text: "Material"),
                Tab(text: "Anggota"),
              ],
            ),
            title: Text(dateFormat.format(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: TabBarView(
            children: [
              TabAktivitas(args),
              if (args.jenis == "Penyemprotan") TabMaterial(args),
              TabAnggota(args),
            ],
          ),
        ),
      ),
    );
  }
}

class TabAktivitas extends StatelessWidget {
  final Aktivitas args;
  TabAktivitas(this.args);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _realisasi = TextEditingController();
  TextEditingController _liter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            ListTile(
              title:
              Text('Aktivitas',
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
            ListTile(
              title:
              Text('Target',
                  style: TextStyle(color: Color(0xFF757575))),
              subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text("${args.target} Ha",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                ],
              ),
              onTap: () {
              },
            ),
            ListTile(
              title:
              Text('Realisasi (Ha)',
                  style: TextStyle(color: Color(0xFF757575))),
              subtitle:
              Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 200),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: args.realisasi == null
                              ? _realisasi
                              : (_realisasi..text = args.realisasi.toString()),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                          ),
                          decoration: new InputDecoration(
                            hintText: args.realisasi == null ? 'Belum Diisi' : "${args.realisasi}",
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan jumlah Ha.';
                            }
                            return null;
                          },
                        ),
                      ),
                      if(args.jenis == "Penyemprotan")
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _liter,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black
                            ),
                            initialValue: args.liter.toString(),
                            decoration: new InputDecoration(
                              hintText: args.liter == null ? 'Belum Diisi' : "${args.realisasi}",
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan jumlah liter yang digunakan.';
                              }
                              return null;
                            },
                          ),
                        ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(_realisasi.text);
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            DatabaseService service = DatabaseService();
            Aktivitas aktivitas = Aktivitas(
              tanggal: args.tanggal,
              jenis: args.jenis,
              kode: args.kode,
              target: args.target,
              realisasi: int.parse(_realisasi.text),
              liter: args.jenis == "Penyemprotan" ? int.parse(_liter.text) : args.liter,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Memproses Data')),
            );
            await service.updateAktivitas(aktivitas);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class TabMaterial extends StatelessWidget {
  final Aktivitas args;
  TabMaterial(this.args);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        args.jenis == "Penyemprotan" ?
        ListTile(
          title:
          Text('Knapsack Sprayer INTER',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
          subtitle:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text('Kuantitas',
                  style: TextStyle(color: Color(0xFF757575))),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              args.liter == null ? Text("Belum terisi") :
              Text("${args.liter} liter",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            ],
          ),
          onTap: () {
          },
        ): SizedBox(),
        Divider(),
      ],
    );
  }
}

class TabAnggota extends StatefulWidget {
  final Aktivitas args;
  TabAnggota(this.args);

  @override
  State<TabAnggota> createState()=>_TabAnggota(args);
}

class _TabAnggota extends State<TabAnggota> {
  final Aktivitas args;
  _TabAnggota(this.args);

  DatabaseService service = DatabaseService();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  final String formatted = formatter.format(now);
  Future<List<Karyawan>>? listKaryawan;
  List<Karyawan>? listTerambil;
  String? namaKaryawan;
  String? idKaryawan;

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listKaryawan = service.ambilKaryawan();
    listTerambil = await service.ambilKaryawan();
  }

  Future<Null> _refresh() {
    return service.ambilKaryawan().then((_list) {
      setState(() => listTerambil = _list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        RefreshIndicator(
          onRefresh: _refresh,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: FutureBuilder(
              future: listKaryawan,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Karyawan>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listTerambil!.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child:Container(
                                  width: double.infinity,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text("${listTerambil![index].id} - ${listTerambil![index].nama}",
                                            style: TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else if (snapshot.connectionState == ConnectionState.done &&
                    listTerambil!.isEmpty) {
                  return Center(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: const <Widget>[
                        SizedBox(height: 20),
                        Align(alignment: AlignmentDirectional.center,
                            child: Text('Data tidak ditemukan', style: TextStyle(fontSize: 20))),
                        SizedBox(height: 15),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}