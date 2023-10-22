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
      systemNavigationBarIconBrightness:
          Brightness.light, 
      statusBarIconBrightness:
          Brightness.light, 
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evcil Dostum Uygulaması',
      theme: ThemeData(
        scaffoldBackgroundColor:  Color.fromARGB(252, 242, 244, 245),
      
        appBarTheme: AppBarTheme( elevation: 0.5,centerTitle: true, backgroundColor: Colors.orange, titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18 )),
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'SFProDisplay',
              )),
      home: ScreensView(),
    );
  }
}
