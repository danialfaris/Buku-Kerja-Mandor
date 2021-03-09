import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kerja Mandor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: myColor,
        fontFamily: 'Roboto',
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Beranda'),
    );
  }
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150.0,
              child: DrawerHeader(
                child: Text('Categories'),
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(0.0)
              ),
            ),
            ListTile(
              title: Text('Beranda'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('BKM Hari Ini'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
            "Beranda",
            style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10,10,10,10),
        height: 1200,
        width: double.maxFinite,
        child: ListView.builder(
            itemCount: 1, // the length
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  color: Color(0xFF4CAF50),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "BKM Hari Ini",
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
            })
      ),
    );
  }
}
