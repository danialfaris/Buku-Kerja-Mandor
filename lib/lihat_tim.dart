import 'package:flutter/material.dart';
import 'drawer.dart';

class LihatTim extends StatelessWidget {
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
              ListTile(
                title: Row(
                  children: [
                    Text('19921000087 - Edi Pangestu',
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
                    Text('19941000007 - Mansur C.',
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