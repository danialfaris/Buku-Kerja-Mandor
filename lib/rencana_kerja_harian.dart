import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'laporan_aktivitas.dart';
import 'drawer.dart';
import 'models/activity_model.dart';
import 'package:intl/intl.dart';

class RencanaKerjaHarian extends StatefulWidget {
  const RencanaKerjaHarian({Key? key}) : super (key: key);

  @override
  State<RencanaKerjaHarian> createState()=>_RencanaKerjaHarianState();
}

class _RencanaKerjaHarianState extends State<RencanaKerjaHarian> {
  DatabaseService service = DatabaseService();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  final String formatted = formatter.format(now);
  Future<List<Aktivitas>>? listAktivitas;
  List<Aktivitas>? listTerambil;

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
          "Rencana Kerja Harian",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
        actions: [
          // action button
          IconButton(
            icon: Icon(Icons.refresh, size: 30),
            onPressed: () { },
          ),
        ],
      ),
      body: Container(
          height: 1200,
          width: double.maxFinite,
          child: ListView(
            children: [
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
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${listTerambil![index].kode} - ${listTerambil![index].jenis}"),
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  "/view",
                                  arguments: listTerambil![index]);
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
          SizedBox(height: 10),
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
        ).then((context) => _refresh());
      },
    ),
    ]
    ),
    ),
    );
  }
}