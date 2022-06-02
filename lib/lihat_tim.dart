import 'package:buku_kerja_mandor/models/karyawan_model.dart';
import 'package:buku_kerja_mandor/services/auth_services.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'models/activity_model.dart';

class LihatTim extends StatefulWidget {
  const LihatTim({Key? key}) : super (key: key);

  @override
  State<LihatTim> createState()=>_LihatTim();
}

class _LihatTim extends State<LihatTim> {
  /**
  DatabaseService service = DatabaseService();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  final String formatted = formatter.format(now);
  Future<List<Karyawan>>? listKaryawan;
  List<Karyawan>? listTerambil;

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    final authService = Provider.of<AuthService>(context);
    listKaryawan = service.ambilKaryawan("rahmat");
    listTerambil = await service.ambilKaryawan("rahmat");
  }

  Future<Null> _refresh() {
    return service.ambilKaryawan("rahmat").then((_list) {
      setState(() => listTerambil = _list);
    });
  }
  **/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Lihat Tim",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            children: [
              /**
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
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text("${listTerambil![index].id} - ${listTerambil![index].nama}",
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      onTap: () {
                                      },
                                    ),
                                    Divider(),
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
                  **/
              ListTile(
                title: Row(
                  children: [
                    Text('1 - Edi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Divider(),
              ListTile(
                title: Row(
                  children: [
                    Text('2 - Dimas',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Divider(),
              ListTile(
                title: Row(
                  children: [
                    Text('3 - Mansur',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Divider(),
            ]
        ),
      ),
    );
  }
}