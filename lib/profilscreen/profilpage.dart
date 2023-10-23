import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Profil Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
