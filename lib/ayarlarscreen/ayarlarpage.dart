import 'package:flutter/material.dart';

class AyarlarPage extends StatelessWidget {
  const AyarlarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Ayarlar Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
