import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:buku_kerja_mandor/kalendar.dart';
import 'package:buku_kerja_mandor/lihat_tim.dart';
import 'package:buku_kerja_mandor/rencana_kerja_harian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'drawer.dart';
import 'bkm.dart';
import 'kalendar.dart';
import 'rencana_kerja_harian.dart';
import 'lihat_tim.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

const MaterialColor myColor = const MaterialColor(
  0xFF388E3C,
  const <int, Color>{
    50: const Color(0xFF388E3C),
    100: const Color(0xFF388E3C),
    200: const Color(0xFF388E3C),
    300: const Color(0xFF388E3C),
    400: const Color(0xFF388E3C),
    500: const Color(0xFF388E3C),
    600: const Color(0xFF388E3C),
    700: const Color(0xFF388E3C),
  }
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: myColor,
        ),
        home:  Beranda(),
      ),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ApplicationDrawer>(
            create: (_) => ApplicationDrawer())
      ],
    );
  }
}

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
                SizedBox(height: 10),
                MenuButton(3),
              ]
          ),
        ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton(this.num);
  final int num;
  final text = ["BKM Hari Ini","Rencana Kerja Harian","Lihat Tim","Kalendar"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(num == 0) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(1);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BKM()),
          );
        }
        if(num == 1) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(2);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RencanaKerjaHarian()),
          );
        }
        if(num == 2) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(3);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LihatTim()),
          );
        }
        if(num == 3) {
          Provider.of<ApplicationDrawer>(context, listen: false).setCurrentDrawer(4);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Kalendar()),
          );
        }
      },
      child: Card(
        color: Color(0xFF74b474),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    text[num],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
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