import 'package:flutter/material.dart';
import 'laporan_aktivitas.dart';
import 'drawer.dart';

class BKM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            "BKM Hari Ini",
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
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked),
                      SizedBox(width: 20),
                      Text('BAAA01 - Semprot Lalang'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Aktivitas()),
                    );
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked),
                      SizedBox(width: 20),
                      Text('T01 - Test'),
                    ],
                  ),
                  onTap: () {
                  },
                ),
                ListTile(
                  tileColor: Color(0xFFC8E6C9),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Input Aktivitas', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF757575))),
                    ],
                  ),
                  onTap: () {
                  },
                ),
              ]
          ),
        ),
      );
    }
}