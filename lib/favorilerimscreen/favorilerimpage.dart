import 'package:flutter/material.dart';

class FavorilerimPage extends StatelessWidget {
  const FavorilerimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Favorilerim Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
