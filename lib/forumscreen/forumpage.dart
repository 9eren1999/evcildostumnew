import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Burası Forum Sayfası",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
