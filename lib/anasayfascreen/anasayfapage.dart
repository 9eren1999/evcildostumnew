import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evcildostum/anasayfascreen/categories.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AnasayfaPage extends StatelessWidget {
Future<DocumentSnapshot> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await FirebaseFirestore.instance
          .collection('kullanicilartable')
          .doc(user.uid) // Oturum açan kullanıcının ID'si burada kullanılır
          .get();
    } else {
      throw Exception('Kullanıcı oturum açmadı');
    }
  }
   void navigateToPage(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        Navigator.pushNamed(context, '/yakinimdaPage');
        break;
      case 1:
        Navigator.pushNamed(context, '/page2');
        break;
      // Diğer sayfalar için durumlar ekleyin
      // case 2: Navigator.pushNamed(context, '/page3'); break;
      // ...
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
  body: Column(  
    children: [
      Expanded( 
        flex: 2,
        child: Container( 
 
          decoration: BoxDecoration( // BoxDecoration ekledik
                color: Colors.red.shade600,
                boxShadow: [ // Gölge efekti ekledik
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ), margin: EdgeInsets.only(bottom: 1),
          child: FutureBuilder(
            future: getUserInfo(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              } else {
                var userInfo = snapshot.data!;
                return Center(
                  child: Column( 
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar( 
                          radius: 35,
                          backgroundImage: NetworkImage(
                              'https://pm1.aminoapps.com/7517/58894a30021ce56ed81b9dea917c7928d98e110dr1-958-811v2_uhq.jpg'), 
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${userInfo['isim']} ${userInfo['soyisim']}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
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
                color: Color.fromARGB(238, 240, 240, 240),
child: ScrollConfiguration(
                  behavior: MyScrollBehavior(), // Özel ScrollBehavior'u kullan
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: GridView.count( 
                    crossAxisCount: 3,
                    
                    children: List.generate(8, (index) {
                      return Card(
                        child: InkWell(
                          onTap: () => navigateToPage(context, index), // Yönlendirme fonksiyonunu burada çağırıyoruz
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                              menuIcons[index], // menuIcons listesini kullanıyoruz
                              size: 35,  
                            ),SizedBox(height: 10,),
                            Text(menuNames[index]), // menuNames listesini kullanıyoruz
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
  ])
      );

  }
}
class MyScrollBehavior extends ScrollBehavior {
  Widget buildViewportDecorations(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}