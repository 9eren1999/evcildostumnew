import 'package:evcildostum/kayitolscreen/kayitolpage.dart';
import 'package:evcildostum/kayitolscreen/step2.dart';
import 'package:evcildostum/navbar/navbar.dart';
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
        primarySwatch: Colors.pink,
      ),
       home: KayitOlPage(),
    );
  }
}
