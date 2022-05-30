import 'package:flutter/material.dart';
import 'main.dart';
import 'laporan_aktivitas.dart';
import 'package:intl/intl.dart';

import 'models/activity_model.dart';

class LihatAktivitas extends StatelessWidget {
  LihatAktivitas({Key? key}) : super(key: key);
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');
  static const routeName = '/view';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Aktivitas;
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
              TabAktivitas(args),
              TabMaterial(args),
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
          Text('Realisasi',
              style: TextStyle(color: Color(0xFF757575))),
          subtitle:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              args.realisasi != null ?
              Text("${args.realisasi} Ha",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF757575))) :
              Text("Belum diisi"),
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

class TabAnggota extends StatelessWidget {
  final Aktivitas args;
  TabAnggota(this.args);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          ListTile(
            title:
                Text('19921000087 - Edi Pangestu',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
            /**
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
                **/
            onTap: () {
            },
          ),
          Divider(),
        ],
    );
  }
}
