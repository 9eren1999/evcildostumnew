import 'package:flutter/material.dart';

class DostlarimPage extends StatelessWidget {
  const DostlarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Dostlarım Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
