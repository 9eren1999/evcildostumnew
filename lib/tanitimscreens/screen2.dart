import 'package:evcildostum/girisyapscreen/girisyappage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
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
                  width: 450,
                  height: 450,
                  child: Lottie.asset('assets/animations/wspage2.json'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "İlan ver, İlan ara!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Evcil Dostun için eş arayabilir, yeni bir dost sahiplenebilir ya da dostuna ulaşamıyorsan hemen kayıp ilanı oluşturabilirsin!',
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
