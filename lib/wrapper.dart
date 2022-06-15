import 'package:buku_kerja_mandor/beranda.dart';
import 'package:buku_kerja_mandor/login.dart';
import 'package:flutter/material.dart';
import 'services/auth_services.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot){
          if (snapshot.connectionState == ConnectionState.active){
            final User? user = snapshot.data;
            print(user?.email);
            authService.setUsername(user?.email);
            print(authService.getUsername);
            return user == null ? LoginPage() : Beranda();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}