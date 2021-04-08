import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';

class LihatAktivitas extends StatelessWidget {
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: myColor),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            bottom: TabBar(
              tabs: [
                Tab(text: "Aktivitas"),
                Tab(text: "Material"),
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
              TabAktivitas(),
              TabMaterial(),
              TabAnggota(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabAktivitas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TabMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TabAnggota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}