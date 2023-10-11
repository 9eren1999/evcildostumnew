import 'package:flutter/material.dart';

class AnasayfaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: Center(
        child: Text(
          'Hoş geldiniz başarılı bir giriş yaptınız, burası anasayfa!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
