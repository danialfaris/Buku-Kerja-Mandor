import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bkm.dart';
import 'application_drawer.dart';

void main() {
  runApp(MyHomePage());
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: myColor,
      ),
      home:  Beranda(),
    );
  }
}

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer("Beranda"),
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
                MenuButton(text: "BKM Hari Ini"),
                SizedBox(height: 10),
                MenuButton(text: "Rencana Kerja Harian"),
                SizedBox(height: 10),
                MenuButton(text: "Lihat Tim"),
                SizedBox(height: 10),
                MenuButton(text: "Kalendar"),
              ]
          ),
        ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer(this.currentPage);
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150.0,
            child: DrawerHeader(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.only(top: 50),
              child: Text('Selamat datang,', style: TextStyle(color: Color(0xFF757575)),),
            ),
          ),
          ListTile(
            tileColor: this.currentPage == "Beranda" ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 20),
                Text('Beranda'),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              if(this.currentPage == "Beranda") return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                    Beranda()
                ),
              );
            },
          ),
          ListTile(
            tileColor: this.currentPage == "BKM" ? Color(0xFFC8E6C9) : Color(0x00000000),
            title: Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 20),
                Text('BKM Hari Ini'),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              if(this.currentPage == "BKM") return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BKM()
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.assignment),
                SizedBox(width: 20),
                Text('Rencana Kerja Harian'),
              ],
            ),
            onTap: () {
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 20),
                Text('Lihat Tim'),
              ],
            ),
            onTap: () {
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 20),
                Text('Kalendar'),
              ],
            ),
            onTap: () {
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
    throw UnimplementedError();
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Color(0xFF74b474),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 50)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}