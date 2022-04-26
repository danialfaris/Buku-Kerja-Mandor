import 'package:buku_kerja_mandor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:buku_kerja_mandor/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SELAMAT DATANG", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 90, top: 20),
              child:
              TextField(
                controller: controller.emailC,
                decoration: new InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFFBDBDBD)),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 90, right: 90, top: 20),
              child:
              TextField(
                controller: controller.passC,
                decoration: new InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFFBDBDBD)),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 80, right: 80, top: 20),
              child:
              GestureDetector(
                onTap: () => authC.login(controller.emailC.text, controller.passC.text),
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun?"),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                    child: Text("DAFTAR SEKARANG")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
