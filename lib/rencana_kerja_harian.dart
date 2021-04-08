import 'package:flutter/material.dart';
import 'drawer.dart';

class RencanaKerjaHarian extends StatelessWidget {
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
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.radio_button_unchecked),
                    SizedBox(width: 20),
                    Text('T00 - Test'),
                  ],
                ),
                onTap: () {
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
            ]
        ),
      ),
    );
  }
}