import 'package:evcildostum/ilanlarscreen/esaramailanekle.dart';
import 'package:evcildostum/navbar/navbar.dart';
import 'package:evcildostum/tanitimscreens/pageview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light, // Navigasyon çubuğu ikonları için parlaklık
      statusBarIconBrightness: Brightness.light, // Durum çubuğu ikonları için parlaklık
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evcil Dostum Uygulaması',
      theme: ThemeData(
        scaffoldBackgroundColor:  Color.fromARGB(255, 247, 244, 247),
      
        appBarTheme: AppBarTheme( elevation: 0.5,centerTitle: true, backgroundColor: Colors.white, titleTextStyle: TextStyle(fontWeight: FontWeight.w800,   fontSize: 18,color: Colors.grey.shade800)),
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'SFProDisplay',
              )),
      home: NavBarPage(),
    );
  }
}
