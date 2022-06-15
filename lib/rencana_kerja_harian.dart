import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'laporan_aktivitas.dart';
import 'drawer.dart';
import 'lihat_aktivitas.dart';
import 'main.dart';
import 'models/activity_model.dart';
import 'package:intl/intl.dart';

import 'models/panen_model.dart';

class RencanaKerjaHarian extends StatefulWidget {
  const RencanaKerjaHarian({Key? key}) : super (key: key);

  @override
  State<RencanaKerjaHarian> createState() => _RencanaKerjaHarianState();
}

class _RencanaKerjaHarianState extends State<RencanaKerjaHarian> {
  DatabaseService service = DatabaseService();
  static DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  String formatted = formatter.format(now);
  Future<List<AktivitasPanen>>? listAktivitas;
  Future<List<Aktivitas>>? listAktivitasPemel;
  List<AktivitasPanen>? listTerambil;
  List<Aktivitas>? listTerambilPemel;

  void initState(){
    now = DateTime.now();
    formatted = formatter.format(now);
    super.initState();
    _initRetrieval();
    _refresh();
  }

  Future<void> _initRetrieval() async {
    listAktivitas = service.ambilAktivitasPanenHari(formatted);
    listAktivitasPemel = service.ambilAktivitasHari(formatted);
    listTerambil = await service.ambilAktivitasPanenHari(formatted);
    listTerambilPemel = await service.ambilAktivitasHari(formatted);
  }

  Future<void> _refresh() async {
    service.ambilAktivitasPanenHari(formatted).then((_list) {
      setState(() => listTerambil = _list);
    });
    service.ambilAktivitasHari(formatted).then((_list) {
      setState(() => listTerambilPemel = _list);
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
                        (BuildContext context, AsyncSnapshot<List<AktivitasPanen>> snapshot) {
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
                                          title: Text(
                                              "${listTerambil![index].jenis}",
                                              style: TextStyle(fontSize: 20)),
                                        )
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder:
                                          (context) => LihatAktivitas(listTerambil![index])
                                      )
                                  ).then(
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
                              SizedBox(height: 20),
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

              SizedBox(height: 5),
              RefreshIndicator(
                onRefresh: _refresh,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: FutureBuilder(
                    future: listAktivitasPemel,
                    builder:
                        (BuildContext context, AsyncSnapshot<List<Aktivitas>> snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listTerambilPemel!.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    listTerambilPemel![index].realisasi == null ?
                                    Icon(Icons.radio_button_unchecked) :
                                    Icon(Icons.radio_button_checked, color: myColor),
                                    SizedBox(width: 20),
                                    Expanded(
                                        child: ListTile(
                                          title: Text(
                                              "${listTerambilPemel![index].jenis}",
                                              style: TextStyle(fontSize: 20)),
                                        )
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      "/viewpemel",
                                      arguments: listTerambilPemel![index])
                                      .then(
                                          (context) => _refresh());
                                },
                              );
                            });
                      } else if (snapshot.connectionState == ConnectionState.done &&
                          listTerambilPemel!.isEmpty) {
                        return Center(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: const <Widget>[
                              SizedBox(height: 20),
                              Align(alignment: AlignmentDirectional.center,
                                  child: Text('Data tidak ditemukan', style: TextStyle(fontSize: 20))),
                              SizedBox(height: 20),
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

              /**/
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
              /**/
            ]
          ),
      ),
    );
  }
}

class _RencanaKerjaHarianPemelState extends State<RencanaKerjaHarian> {
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
                                          title: Text(
                                              "${listTerambil![index].jenis}",
                                              style: TextStyle(fontSize: 20)),
                                        )
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      "/view",
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
                              SizedBox(height: 20),
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
                  ).then((context) => _refresh());
                },
              ),
              **/
            ]
        ),
      ),
    );
  }
}