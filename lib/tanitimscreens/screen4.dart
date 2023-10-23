import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 310,
                  height: 350,
                  child: Lottie.asset('assets/animations/wspage4.json'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Dostunu uzaktan takip et!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Evcil Dostum "İz İzleyici" tasmalar ile evcil dostunun konumunu dilediğin yerden kesintisiz takip et!',
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
