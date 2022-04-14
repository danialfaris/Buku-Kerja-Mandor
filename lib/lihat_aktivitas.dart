import 'package:flutter/material.dart';
import 'main.dart';
import 'laporan_aktivitas.dart';
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
              Text('BAAA01 - Semprot Lalang',
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
              Text('A02',
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
              Text('04',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            ],
          ),
          onTap: () {
          },
        ),
      ],
    );
  }
}

class TabMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
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
              Text('3 pc(s)',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            ],
          ),
          onTap: () {
          },
        ),
        Divider(),
      ],
    );
  }
}

class TabAnggota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          ListTile(
            title:
                Text('19921000087 - Edi Pangestu',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text('Hasil Kerja Riil',
                        style: TextStyle(color: Color(0xFF757575))),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text('3 ha dari 2.5 ha',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
            onTap: () {
            },
          ),
          Divider(),
        ],
    );
  }
}