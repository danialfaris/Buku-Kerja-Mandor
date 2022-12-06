import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:buku_kerja_mandor/kalender.dart';
import 'package:buku_kerja_mandor/lihat_tim.dart';
import 'package:buku_kerja_mandor/rencana_kerja_harian.dart';
import 'package:buku_kerja_mandor/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'bkm.dart';
import 'kalender.dart';
import 'rencana_kerja_harian.dart';
import 'lihat_tim.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Beranda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15,15,15,10),
        height: 1200,
        width: double.maxFinite,
        child: ListView(
            children: <Widget>[
              MenuButton(0),
              SizedBox(height: 10),
              MenuButton(1),
              SizedBox(height: 10),
              MenuButton(2),
            ]
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton(this.num);
  final int num;
  final text = ["Rencana Kerja Harian","Lihat Tim","Kalender"];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return GestureDetector(
      onTap: () {
        if(num == 0) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(1);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RencanaKerjaHarian(authService.getRole)),
          );
        }
        if(num == 1) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LihatTim()),
          );
        }
        if(num == 2) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(3);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Kalender()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/${text[num]}.png'),
            fit: BoxFit.fitWidth,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        text[num],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}