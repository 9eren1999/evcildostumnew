import 'package:evcildostum/blogscreen/bloglarpage.dart';
import 'package:evcildostum/tanitimscreens/pageview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evcil Dostum Uygulaması',
      theme: ThemeData(
      
        appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.orange, titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18 )),
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'SFProDisplay',
              )),
      home: BloglarPage(),
    );
  }
}
