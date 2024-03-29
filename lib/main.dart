import 'package:buku_kerja_mandor/laporan_aktivitas.dart';
import 'package:buku_kerja_mandor/lihat_aktivitas.dart';
import 'package:buku_kerja_mandor/models/panen_model.dart';
import 'package:buku_kerja_mandor/services/auth_services.dart';
import 'package:buku_kerja_mandor/tambah_aktivitas.dart';
import 'package:buku_kerja_mandor/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lapor_panen.dart';
import 'lihat_aktivitas_pemel.dart';
import 'login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'application_drawer.dart';
import 'models/activity_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom
  ] );
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
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<ApplicationDrawer>(
            create: (_) => ApplicationDrawer()
        ),
        ChangeNotifierProvider(
            create: (_) => FormProvider()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: myColor,
            fontFamily: 'Roboto',
          ),
          initialRoute: '/',
          routes:{
            '/': (context) => Wrapper(),
            '/login': (context) => LoginPage(),
            '/edit' : (context) => LaporAktivitas(),
            '/viewpemel' : (context) => LihatAktivitasPemel(),
          }
      ),
    );
  }
}