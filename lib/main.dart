import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'drawer.dart';

void main() {
  runApp(MyApp());
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