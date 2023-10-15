import 'dart:math';

import 'package:evcildostum/isimonericiscreen/fonksiyonlarveparametreler.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IsimOnericiPage extends StatefulWidget {
  @override
  _IsimOnericiPageState createState() => _IsimOnericiPageState();
}

class _IsimOnericiPageState extends State<IsimOnericiPage> {
  String? secilenTur;
  String? secilenCinsiyet;
  String? onerilenIsim;
  bool showAnimation = false;

  void isimOner() {
    setState(() {
      showAnimation = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      if (secilenTur != null && secilenCinsiyet != null) {
        var rastgele = Random();
        var tur = isimler[secilenTur];
        var cinsiyet = tur![secilenCinsiyet];
        onerilenIsim = cinsiyet![rastgele.nextInt(cinsiyet.length)];
        setState(() {
          showAnimation = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset('assets/animations/arkaplan_resmi.json',
                fit: BoxFit.cover),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.005,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<String>(
                    value: secilenTur,
                    hint: Text('Tür'),
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenTur = newValue;
                      });
                    },
                    items: <String>['Kedi', 'Köpek']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<String>(
                    value: secilenCinsiyet,
                    hint: Text('Cinsiyet'),
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenCinsiyet = newValue;
                      });
                    },
                    items: <String>['Erkek', 'Dişi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: isimOner,
                  child: Text('İsim Öner'),
                ),
                if (showAnimation)
                  Lottie.asset('assets/animations/isimsecis.json'),
                if (onerilenIsim != null && !showAnimation)
                  Container(
                    child: Text(
                      'Önerilen İsim: $onerilenIsim',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
