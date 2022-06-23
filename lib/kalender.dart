import 'dart:collection';

import 'package:buku_kerja_mandor/main.dart';
import 'package:buku_kerja_mandor/services/auth_services.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/activity_model.dart';
import 'models/hasil_kerja_model.dart';
import 'models/karyawan_model.dart';
import 'models/panen_model.dart';

class Kalender extends StatefulWidget{
  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');

  DatabaseService service = DatabaseService();
  Future<List<Aktivitas>>? listAktivitasPemel;
  List<Aktivitas>? listTerambilPemel;
  Future<List<AktivitasPanen>>? listAktivitasPanen;
  List<AktivitasPanen>? listTerambilPanen;

  void initState(){
    _focusedDay = DateTime.now();
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listAktivitasPemel = service.ambilAktivitasHari(formatter.format(_focusedDay));
    listTerambilPemel = await service.ambilAktivitasHari(formatter.format(_focusedDay));
    listAktivitasPanen = service.ambilAktivitasPanenHari(formatter.format(_focusedDay));
    listTerambilPanen = await service.ambilAktivitasPanenHari(formatter.format(_focusedDay));
  }

  Future<void> _setRetrieval(date) async {
    setState(() async {
      listAktivitasPemel = service.ambilAktivitasHari(date);
      listTerambilPemel = await service.ambilAktivitasHari(date);
      listAktivitasPanen = service.ambilAktivitasPanenHari(date);
      listTerambilPanen = await service.ambilAktivitasPanenHari(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Kalender",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: TableCalendar(
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = 'Mgu';
              return Center(
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              );
            }
            var days = ['Sen','Sel','Rab','Kam','Jum','Sab'];
            final text = days[day.weekday - DateTime.monday];
            return Center(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),

        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration (
            color: Color(0xFFD32F2F),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration (
            color: myColor,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
          weekendTextStyle: TextStyle(color: Colors.red),
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF757575))
        ),
        locale: 'in_ID',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        weekendDays: [DateTime.sunday],


        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.

          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
          String formatted = formatter.format(selectedDay);
          _setRetrieval(formatted);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    formatted,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: ListView(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: FutureBuilder(
                            future: listAktivitasPanen,
                            builder:
                                (BuildContext context, AsyncSnapshot<List<AktivitasPanen>> snapshot) {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                return ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: listTerambilPanen!.length,
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text("${listTerambilPanen![index].jenis}"),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder:
                                                  (context) => HanyaLihatAktivitasPanen(listTerambilPanen![index])
                                              )
                                          );
                                        },
                                      );
                                    });
                              } else if (snapshot.connectionState == ConnectionState.done &&
                                  listTerambilPanen!.isEmpty) {
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
                      Container(
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
                                        title: Text("${listTerambilPemel![index].kode} - ${listTerambilPemel![index].jenis}"),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder:
                                                  (context) => HanyaLihatAktivitasPemel(listTerambilPemel![index])
                                              )
                                          );
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
                      Divider(),
                    ]
                ),
              );
            },
          );
          /**
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RKH(formatted)),
          );
              **/
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class HanyaLihatAktivitasPanen extends StatefulWidget {
  final AktivitasPanen args;
  HanyaLihatAktivitasPanen(this.args);

  @override
  State<HanyaLihatAktivitasPanen> createState()=>_HanyaLihatAktivitasPanen(args);
}

class _HanyaLihatAktivitasPanen extends State<HanyaLihatAktivitasPanen> {
  final AktivitasPanen args;
  _HanyaLihatAktivitasPanen(this.args);

  DatabaseService service = DatabaseService();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');
  final String formatted = formatter.format(now);
  List<Karyawan>? listKaryawan;
  LinkedHashMap? listHasilKerja;
  HasilKerja hasilKerjaTotal = HasilKerja();
  String? namaKaryawan;
  String? idKaryawan;

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listKaryawan = await service.ambilKaryawan(args.mandor);
    listHasilKerja = await service.ambilHasilKerja(args.id);
    hasilKerjaTotal = await service.ambilHasilKerjaTotal(args.id);
    _refresh();
  }

  Future<void> _refresh() async {
    service.ambilKaryawan(args.mandor).then((_list) {
      setState(() => listKaryawan = _list);
    });
    service.ambilHasilKerja(args.id).then((_list) {
      setState(() => listHasilKerja = _list);
    });
    service.ambilHasilKerjaTotal(args.id).then((_hk) {
      setState(() => hasilKerjaTotal = _hk);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporan Panen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body:
      Container(
        padding: EdgeInsets.fromLTRB(15,15,15,10),
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text("Mandor: ${args.mandor}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Text("Tanggal: ${args.tanggal}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  defaultColumnWidth: FixedColumnWidth(80.0),
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
                    if (listKaryawan != null)
                      for (var o in listKaryawan! ) (
                          TableRow( children: [
                            Column(children:[Text(o.id)]),
                            Column(children:[Text(o.nama)]),
                            Column(children:[Text(listHasilKerja![o.id]["tahun"])]),
                            Column(children:[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black
                                ),
                                initialValue: listHasilKerja![o.id]["blok"],
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onChanged: (value) {
                                  listHasilKerja![o.id]["blok"] = value;
                                },
                              ),
                            ]),
                            Column(children:[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black
                                ),
                                initialValue: listHasilKerja![o.id]["jelajah"].toString(),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onChanged: (value) {
                                  listHasilKerja![o.id]["jelajah"] = value;
                                },
                              ),
                            ]),
                            Column(children:[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black
                                ),
                                initialValue: listHasilKerja![o.id]["tandan"].toString(),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onChanged: (value) {
                                  listHasilKerja![o.id]["tandan"] = value;
                                },
                              ),
                            ]),
                            Column(children:[Text('${listHasilKerja![o.id]["kg"]}')]),
                            Column(children:[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black
                                ),
                                initialValue: listHasilKerja![o.id]["brd"].toString(),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onChanged: (value) {
                                  listHasilKerja![o.id]["brd"] = value;
                                },
                              ),
                            ]),
                            Column(children:[Text('${listHasilKerja![o.id]["jml"]}')]),
                            Column(children:[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black
                                ),
                                initialValue: listHasilKerja![o.id]["pikul"].toString(),
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onChanged: (value) {
                                  listHasilKerja![o.id]["pikul"] = value;
                                },
                              ),
                            ]),
                          ])
                      ),
                    TableRow( children: [
                      Column(children:[Text('Total', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center)]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text('')]),
                      Column(children:[Text(hasilKerjaTotal.jelajah.toString())]),
                      Column(children:[Text(hasilKerjaTotal.tandan.toString())]),
                      Column(children:[Text(hasilKerjaTotal.kg.toString())]),
                      Column(children:[Text(hasilKerjaTotal.brd.toString())]),
                      Column(children:[Text(hasilKerjaTotal.jml.toString())]),
                      Column(children:[Text(hasilKerjaTotal.pikul.toString())]),
                    ]),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}

class HanyaLihatAktivitasPemel extends StatelessWidget {
  final Aktivitas args;
  HanyaLihatAktivitasPemel(this.args);
  DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'in_ID');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: myColor),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Aktivitas"),
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
              Text('Mandor',
                  style: TextStyle(color: Color(0xFF757575))),
              subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text("${args.mandor}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                ],
              ),
            ),
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
            ),
            Divider(),
            ListTile(
              title:
              Text('Realisasi',
                  style: TextStyle(color: Color(0xFF757575))),
              subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(args.realisasi == null ? 'Belum Diisi' : "${args.realisasi} Ha",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                ],
              ),
            ),
            if (args.jenis == "Penyemprotan")
            ListTile(
              title:
              Text('Jumlah Liter',
                  style: TextStyle(color: Color(0xFF757575))),
              subtitle:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(args.realisasi == null ? 'Belum Diisi' : "${args.liter} Liter",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                ],
              ),
            ),
          ],
        ),
      ),
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
    listKaryawan = service.ambilKaryawan('rahmat');
    listTerambil = await service.ambilKaryawan('rahmat');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        FutureBuilder(
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
        Divider(),
      ],
    );
  }
}