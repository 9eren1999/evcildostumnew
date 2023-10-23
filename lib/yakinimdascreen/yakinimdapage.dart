import 'package:flutter/material.dart';

class YakinimdaPage extends StatelessWidget {
  const YakinimdaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Yakınımda Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
