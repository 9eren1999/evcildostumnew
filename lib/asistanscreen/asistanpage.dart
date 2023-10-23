import 'package:flutter/material.dart';

class AsistanPage extends StatelessWidget {
  const AsistanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Asistan Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
