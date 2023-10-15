import 'package:evcildostum/girisyapscreen/girisyappage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GirisYapPage()),
                  );
                },
                child: Text('Geç',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 230, // Genişliği
                  height: 250, // Yüksekliği
                  child: Lottie.asset('assets/animations/wspage3.json'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Tam zamanlı yardımcın, Asistan!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Asistan ile sevimli dostunun aşı takibini yapabilir, hatırlatıcılar oluşturabilir ya da sağlık bilgilerine ulaşabilirsin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromARGB(239, 255, 255, 255)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
