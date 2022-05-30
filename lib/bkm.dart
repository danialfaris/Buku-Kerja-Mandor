import 'package:buku_kerja_mandor/main.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'laporan_aktivitas.dart';
import 'drawer.dart';
import 'models/activity_model.dart';
import 'package:intl/intl.dart';

class BKM extends StatefulWidget {
  const BKM({Key? key}) : super (key: key);

  @override
  State<BKM> createState()=>_BKMState();
}

class _BKMState extends State<BKM> {
  DatabaseService service = DatabaseService();
  Future<List<Aktivitas>>? listAktivitas;
  List<Aktivitas>? listTerambil;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  final String formatted = formatter.format(now);

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listAktivitas = service.ambilAktivitasHari(formatted);
    listTerambil = await service.ambilAktivitasHari(formatted);
  }

  Future<Null> _refresh() {
    return service.ambilAktivitasHari(formatted).then((_list) {
      setState(() => listTerambil = _list);
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            "BKM Hari Ini",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 10,
          actions: [
            // action button
            IconButton(
              icon: Icon(Icons.refresh, size: 30),
              onPressed: _refresh,
            ),
          ],
        ),
        body: Container(
          height: 1200,
          width: double.maxFinite,
          child: ListView(
              children: [
                SizedBox(height: 5),
                RefreshIndicator(
                  onRefresh: _refresh,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: FutureBuilder(
                      future: listAktivitas,
                      builder:
                          (BuildContext context, AsyncSnapshot<List<Aktivitas>> snapshot) {
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
                                      listTerambil![index].realisasi == null ?
                                      Icon(Icons.radio_button_unchecked) :
                                          Icon(Icons.radio_button_checked, color: myColor),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: ListTile(
                                            title: Text("${listTerambil![index].kode} - ${listTerambil![index].jenis}",
                                              style: TextStyle(fontSize: 20)),
                                          )
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            "/edit",
                                            arguments: listTerambil![index])
                                            .then(
                                                (context) => _refresh());
                                  },
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
                /**
                ListTile(
                  tileColor: Color(0xFFC8E6C9),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tambah Aktivitas', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TambahAktivitas()),
                    );
                  },
                ),**/
              ]
          ),
        ),
      );
    }
}