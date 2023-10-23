import 'package:flutter/material.dart';

class BeslenmePage extends StatelessWidget {
  const BeslenmePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Beslenme Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
