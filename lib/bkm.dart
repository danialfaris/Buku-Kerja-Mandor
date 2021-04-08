import 'package:flutter/material.dart';
import 'drawer.dart';

class BKM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return Scaffold(
        drawer: MyDrawer("BKM"),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
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