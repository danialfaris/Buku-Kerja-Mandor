import 'package:flutter/material.dart';
import 'main.dart';
import 'bkm.dart';
import 'package:intl/intl.dart';

class Aktivitas2 extends StatelessWidget {

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

class Aktivitas extends StatelessWidget {
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Penggunaan Material",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        height: 1200,
        width: double.maxFinite,
        child: ListView(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LaporanAktivitas()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class LaporanAktivitas extends StatelessWidget {
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Penggunaan Material",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text('Knapsack Sprayer INTER', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 200, left: 20),
                child: TextField(
                  controller: TextEditingController(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black
                  ),
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    ),
                    hintText: 'Kuantitas',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              ListTile(
                tileColor: Color(0xFFC8E6C9),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Input Penggunaan Material', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                  ],
                ),
                
                onTap: () {
                },
              ),

            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BKM()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}