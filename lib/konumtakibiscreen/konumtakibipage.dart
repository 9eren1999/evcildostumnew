import 'package:flutter/material.dart';

class KonumTakibiPage extends StatelessWidget {
  const KonumTakibiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası GPS Takip Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
