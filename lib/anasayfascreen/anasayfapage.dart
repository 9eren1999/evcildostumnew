import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evcildostum/anasayfascreen/menuikonlari.dart';
import 'package:evcildostum/asistanscreen/asistanpage.dart';
import 'package:evcildostum/ayarlarscreen/ayarlarpage.dart';
import 'package:evcildostum/beslenmescreen/beslenmepage.dart';
import 'package:evcildostum/bildirimlerscreen/bildirimlerpage.dart';
import 'package:evcildostum/desteksistemiscreen/desteksistemipage.dart';
import 'package:evcildostum/favorilerimscreen/favorilerimpage.dart';
import 'package:evcildostum/isimonericiscreen/isimonericipage.dart';
import 'package:evcildostum/profilscreen/profilpage.dart';
import 'package:evcildostum/yakinimdascreen/yakinimdapage.dart';
import 'package:progress_border/progress_border.dart';
import 'package:evcildostum/kayitolscreen/ekdosteklepage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AnasayfaPage extends StatefulWidget {
  @override
  _AnasayfaPageState createState() => _AnasayfaPageState();
}

class _AnasayfaPageState extends State<AnasayfaPage> {
  int selectedPetIndex = 0;
  late Map<String, dynamic> userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserInfo().then((data) {
      setState(() {
        userInfo = data.data() as Map<String, dynamic>;
        isLoading = false;
      });
    }).catchError((error) {
      // Hata işleme
    });
  }

  Future<DocumentSnapshot> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await FirebaseFirestore.instance
          .collection('kullanicilartable')
          .doc(user.uid)
          .get();
    } else {
      throw Exception('Kullanıcı oturum açmadı');
    }
  }

  void navigateToPage(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YakinimdaPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BeslenmePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AsistanPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IsimOnericiPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavorilerimPage()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DestekSistemiPage()),
        );
        break;

      default:
        break;
    }
  }

  String calculateAge(String birthDateString) {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.parse(birthDateString);

    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += 12;
    }

    if (days < 0) {
      months--;
      days += 30;
    }

    if (years > 0) {
      if (months > 0) {
        return '$years yaş, $months ay';
      }
      return '$years yaş';
    } else if (months > 0) {
      return '$months ay';
    } else {
      return 'Yeni doğan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.amber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('kullanicilartable')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Hata: ${snapshot.error}'));
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('Veri bulunamadı'));
                } else {
                  var userInfo = snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfilPage()),
                                      );
                                    },
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${userInfo['isim']} ${userInfo['soyisim']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.notifications,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BildirimlerPage()),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.settings,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AyarlarPage()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            child: ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: Padding(
                padding: const EdgeInsets.only(left: 27, right: 27, top: 115),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(6, (index) {
                    return Card(
                      color: menuColors[index].withOpacity(0.75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () => navigateToPage(context, index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                menuIcons[index],
                                size: 28,
                                color: Colors.white, // İkonun rengi
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              menuNames[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white, // Metnin rengi
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ]),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.12,
          left: 40,
          right: 40,
          child: Container(
              height: 235,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 2), // Yatay ve dikey konumlandırma
                  ),
                ],
              ),
              child: FutureBuilder<DocumentSnapshot>(
                future: getUserInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Hata: ${snapshot.error}'));
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('Veri bulunamadı'));
                  } else {
                    var userInfo =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var petsKeys = ['pets', 'pets2', 'pets3'];

                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, left: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Evcil Dostlarım",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.grey.shade800)),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                size: 24,
                                color: Colors.grey.shade800,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EkHayvanEklePage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 95,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: petsKeys.length,
                          itemBuilder: (context, index) {
                            var petsList =
                                userInfo[petsKeys[index]] as List<dynamic>? ??
                                    [];

                            return petsList.isEmpty
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPetIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: selectedPetIndex == index
                                                  ? 60
                                                  : 60,
                                              height: selectedPetIndex == index
                                                  ? 60
                                                  : 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: (selectedPetIndex ==
                                                        index)
                                                    ? ProgressBorder.all(
                                                        color:
                                                            Colors.orange[300]!,
                                                        width: 3,
                                                        progress: 100,
                                                      )
                                                    : null,
                                              ),
                                              child: CircleAvatar(
                                                radius:
                                                    selectedPetIndex == index
                                                        ? 30
                                                        : 30,
                                                backgroundImage: NetworkImage(
                                                    petsList[0]['imageUrl']),
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              '${petsList[0]['name']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: Colors.grey.shade800),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Divider(
                          color: Colors.black12,
                          thickness: 1,
                          indent: 15,
                          endIndent: 15),
                      if (userInfo[petsKeys[selectedPetIndex]] != null &&
                          userInfo[petsKeys[selectedPetIndex]].isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/yas.png',
                                  cacheHeight: 35,
                                  cacheWidth: 35,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 60,
                                  child: Text(
                                    calculateAge(
                                        '${userInfo[petsKeys[selectedPetIndex]][0]['dogum_tarihi']}'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.grey.shade800),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/weight.png',
                                  cacheHeight: 35,
                                  cacheWidth: 35,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 60,
                                  child: Text(
                                    '${userInfo[petsKeys[selectedPetIndex]][0]['kilo']} Gr',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.grey.shade800),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                           Column(
  children: [
    Image.asset(
      'assets/images/irk.png',
      cacheHeight: 35,
      cacheWidth: 35,
    ),
    SizedBox(height: 5),
    Container(
      width: 70,
      child: Text(
        '${userInfo[petsKeys[selectedPetIndex]][0]['irk']}',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Colors.grey.shade800),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,  // Metni "..." ile kısalt
      ),
    ),
  ],
),
                          ],
                        ),
                    ]);
                  }
                },
              )))
    ]));
  }
}

class MyScrollBehavior extends ScrollBehavior {
  Widget buildViewportDecorations(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
