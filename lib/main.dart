import 'package:buku_kerja_mandor/app/modules/auth/controllers/auth_controller.dart';
import 'package:buku_kerja_mandor/app/modules/home/views/home_view.dart';
import 'package:buku_kerja_mandor/app/modules/login/views/login_view.dart';
import 'package:buku_kerja_mandor/app/utils/loading.dart';
import 'package:buku_kerja_mandor/application_drawer.dart';
import 'package:buku_kerja_mandor/kalendar.dart';
import 'package:buku_kerja_mandor/lihat_tim.dart';
import 'package:buku_kerja_mandor/rencana_kerja_harian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'app/routes/app_pages.dart';
import 'login.dart';
import 'drawer.dart';
import 'bkm.dart';
import 'kalendar.dart';
import 'rencana_kerja_harian.dart';
import 'lihat_tim.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot){
        print(snapshot);
        if(snapshot.connectionState == ConnectionState.active){
          print(snapshot.data);
          return MultiProvider(
            child: GetMaterialApp(
              initialRoute: snapshot.data != null? Routes.HOME : Routes.LOGIN,
              theme: ThemeData(
                primarySwatch: myColor,
                fontFamily: 'Roboto',
              ),
              getPages: AppPages.routes,
              // home: snapshot.data != null? HomeView() : LoginView(),
            ),
            providers: <SingleChildWidget>[
              ChangeNotifierProvider<ApplicationDrawer>(
                  create: (_) => ApplicationDrawer())
            ],
          );
        }
        return LoadingView();
        },
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
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/${text[num]}.png'),
            fit: BoxFit.fitWidth,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        text[num],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize:20, color: Colors.white),
                      ),
                    ],
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