import 'package:buku_kerja_mandor/main.dart';
import 'package:buku_kerja_mandor/services/database_service.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'drawer.dart';
import 'package:intl/intl.dart';

import 'models/activity_model.dart';

class Kalender extends StatefulWidget{
  @override
  _KalenderState createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  static final DateFormat formatter = DateFormat('dd MMMM yyyy', 'in_ID');

  DatabaseService service = DatabaseService();
  Future<List<Aktivitas>>? listAktivitas;
  List<Aktivitas>? listTerambil;

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listAktivitas = service.ambilAktivitasHari(formatter.format(_focusedDay));
    listTerambil = await service.ambilAktivitasHari(formatter.format(_focusedDay));
  }


  Future<void> _setRetrieval(date) async {
    setState(() async {
      listAktivitas = service.ambilAktivitasHari(date);
      listTerambil = await service.ambilAktivitasHari(date);
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

class RKH extends StatefulWidget {
  RKH(this.date);
  final String date;
  @override
  State<RKH> createState()=>_RKHState(date);
}

class _RKHState extends State<RKH> {
  _RKHState(this.date);
  final String date;
  DatabaseService service = DatabaseService();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
  final String formatted = formatter.format(now);
  Future<List<Aktivitas>>? listAktivitas;
  List<Aktivitas>? listTerambil;

  void initState(){
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    listAktivitas = service.ambilAktivitasHari(date);
    listTerambil = await service.ambilAktivitasHari(date);
  }

  Future<Null> _refresh() {
    return service.ambilAktivitasHari(date).then((_list) {
      setState(() => listTerambil = _list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
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
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("${listTerambil![index].kode} - ${listTerambil![index].jenis}"),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      "/view",
                                      arguments: listTerambil![index])
                                      .then((context) => _refresh());
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
              Divider(),
            ]
        ),
      ),
    );
  }
}