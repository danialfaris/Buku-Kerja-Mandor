import 'package:buku_kerja_mandor/rencana_kerja_harian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'bkm.dart';
import 'kalendar.dart';
import 'rencana_kerja_harian.dart';
import 'lihat_tim.dart';
import 'application_drawer.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentDrawer = Provider.of<ApplicationDrawer>(context).getCurrentDrawer;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150.0,
            child: DrawerHeader(
              margin: EdgeInsets.only(left: 10.0),
              padding: EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('images/icon.png', height: 80, width: 80,),
                  Text("Selamat datang, ", style: TextStyle(color: Color(0xFF757575)),)
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: currentDrawer == 0 ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 20),
                Text('Beranda'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              if(currentDrawer == 0) return;
              Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(0);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Beranda()
                ),
              );
            },
          ),
          ListTile(
            tileColor: currentDrawer == 1 ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 20),
                Text('BKM Hari Ini'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              if(currentDrawer == 1) return;
              Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(1);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BKM()
                ),
              );
            },
          ),
          ListTile(
            tileColor: currentDrawer == 2 ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.assignment),
                SizedBox(width: 20),
                Text('Rencana Kerja Harian'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              if(currentDrawer == 2) return;
              Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(2);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        RencanaKerjaHarian()
                ),
              );
            },
          ),
          ListTile(
            tileColor: currentDrawer == 3 ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 20),
                Text('Lihat Tim'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              if(currentDrawer == 3) return;
              Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(3);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LihatTim()
                ),
              );
            },
          ),
          ListTile(
            tileColor: currentDrawer == 4 ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 20),
                Text('Kalendar'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              if(currentDrawer == 4) return;
              Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(4);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Kalendar()
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 20),
                Text('Pengaturan'),
              ],
            ),
            onTap: () {
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 20),
                Text('Logout'),
              ],
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}