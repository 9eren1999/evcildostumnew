import 'package:flutter/material.dart';

class BildirimlerPage extends StatelessWidget {
  const BildirimlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Bildirimler Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
