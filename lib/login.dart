import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'drawer.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SELAMAT DATANG", style: TextStyle(color: myColor, fontSize: 30, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 90, top: 20),
              child:
              TextField(
                decoration: new InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFFBDBDBD)),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(3)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 90, top: 20),
              child:
              TextField(
                decoration: new InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFFBDBDBD)),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(3)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80, right: 80, top: 20),
              child:
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Beranda()),
                  );
                },
                child: Card(
                  color: Color(0xFF388E3C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}