import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_services.dart';
import 'drawer.dart';
import 'main.dart';
import 'beranda.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailC = TextEditingController();
    TextEditingController _passC = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/icon.png',height: 75),
            SizedBox(height: 20),
            Text("SELAMAT DATANG", style: TextStyle(color: myColor, fontSize: 30, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 90, top: 20),
              child:
              TextField(
                controller: _emailC,
                decoration: new InputDecoration(
                    hintText: "Email",
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
                controller: _passC,
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
                  authService.signInWithEmailAndPassword(
                    _emailC.text,
                    _passC.text,
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