import 'package:buku_kerja_mandor/lapor_panen.dart';
import 'package:buku_kerja_mandor/login.dart';
import 'package:buku_kerja_mandor/services/auth_services.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'laporan_aktivitas.dart';
import 'package:intl/intl.dart';
import 'package:editable/editable.dart';

import 'models/activity_model.dart';
import 'models/karyawan_model.dart';
import 'models/panen_model.dart';

/**
class LihatAktivitas extends StatefulWidget {
  LihatAktivitas({Key? key}) : super(key: key);

  @override
  State<LihatAktivitas> createState()=>_LihatAktivitas();
}

class _LihatAktivitas extends State<LihatAktivitas> {

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
    final args = ModalRoute.of(context)!.settings.arguments as AktivitasPanen;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pelaporan Panen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body:
      TablePage(),
      /**
      Container(
        padding: EdgeInsets.fromLTRB(15,15,15,10),
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  defaultColumnWidth: FixedColumnWidth(75.0),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 0),
                  children: [
                    TableRow( children: [
                      Column(children:[Text('ID', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Nama', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Tahun', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Kode Blok', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Luas Jelajah', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Tandan', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('KG', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('BRD', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Jml', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('Pikul', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                    ]),
                    TableRow( children: [
                      Column(children:[Text('1')]),
                      Column(children:[Text('Edi')]),
                      Column(children:[Text('thn')]),
                      Column(children:[
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                          ),
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                    ]),
                  ],
                ),
              ),
            ]
        ),
      ),**/
    );
  }
}

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {

  List headers = [
    {"title":'ID', 'index': 1, 'key':'id'},
    {"title":'Nama', 'index': 2, 'key':'nama'},
  ];
  List rows = [
    {"ID":'1', "Nama":'Edi'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Editable(
          columns: headers,
          rows: rows,
          tdStyle: TextStyle(fontSize: 20),
          showSaveIcon: false,
          borderColor: Colors.grey.shade300,
        ),
    );
  }
}
 **/

/**/
class LihatAktivitas extends StatelessWidget {
  LihatAktivitas({Key? key}) : super(key: key);
  DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'in_ID');
  static const routeName = '/view';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AktivitasPanen;
    return MaterialApp(
      theme: ThemeData(primarySwatch: myColor),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Aktivitas"),
                //Tab(text: "Material"),
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
              //TabMaterial(args),
              TabAnggota(args),
            ],
          ),
        ),
      ),
    );
  }
}

class TabAktivitas extends StatelessWidget {
  final AktivitasPanen args;
  TabAktivitas(this.args);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              Text("${args.jenis}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            ],
          ),
          onTap: () {
          },
        ),
        /**
        Container(
          margin: EdgeInsets.all(5),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(10.0),
            border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1),
            children: [
              TableRow( children: [
                Column(children:[Text('Tahun', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Blok', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Luas Jelajah', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Tdn', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('KG', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('KRD', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('ml', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('p', style: TextStyle(fontSize: 20.0))]),
              ]),
              TableRow( children: [
                Column(children:[Text('Javatpoint')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('Javatpoint')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('Javatpoint')]),
                Column(children:[Text('Flutter')]),
              ]),
            ],
          ),
        ),
            **/
      ],
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
  final AktivitasPanen args;
  TabAnggota(this.args);

  @override
  State<TabAnggota> createState()=>_TabAnggota(args);
}

class _TabAnggota extends State<TabAnggota> {
  final AktivitasPanen args;
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
                                        onTap: () {
                                        },
                                      ),
                                    ),
                                ),
                                ElevatedButton(
                                  onPressed: ()
                                    async {
                                      Navigator.push(context, new MaterialPageRoute(
                                          builder: (context) => new LaporPanen(args, listTerambil![index]))
                                      ).then(
                                              (context) => _refresh());
                                    },
                                  child: Icon(Icons.edit, color: Colors.white, size: 20),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(10),
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

    /**/