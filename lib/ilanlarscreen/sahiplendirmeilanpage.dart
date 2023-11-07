import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evcildostum/ilanlarscreen/sahiplendirmedetaypage.dart';
import 'package:flutter/material.dart';

class SahiplendirmeIlanPage extends StatefulWidget {
  const SahiplendirmeIlanPage({Key? key}) : super(key: key);

  @override
  State<SahiplendirmeIlanPage> createState() => _SahiplendirmeIlanPageState();
}

class _SahiplendirmeIlanPageState extends State<SahiplendirmeIlanPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sahiplendirmeIlan =
        FirebaseFirestore.instance.collection('sahiplendirmeilantable');

    return Scaffold(
        appBar: AppBar(
          title: Text('Sahiplendirme İlanları'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.grey.shade800, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<QuerySnapshot>(
                future: sahiplendirmeIlan.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Bir hata oluştu: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 9,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      bool isPremium = data['premium'];
                      Color cardColor;

                      cardColor = (data['cinsiyet'] == 'Dişi')
                          ? Colors.pinkAccent.shade100.withOpacity(0.8)
                          : Colors.blue.shade800.withOpacity(0.6);

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SahiplendirmeDetayScreen(
                                    documentId: document.id),
                              ),
                            );
                          },
                          child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(children: [
                                  Image.network(
                                    data['gorsel'],
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  if (isPremium)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        color: (data['cinsiyet'] == 'Dişi')
                                            ? Colors.pink.shade400
                                                .withOpacity(0.9)
                                            : Colors.blue.shade600
                                                .withOpacity(0.9),
                                        child: Text(
                                          'Öne Çıkan',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.transparent, cardColor],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${data['tur']}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' (${data['yas']} aylık)',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 0.4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, left: 8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            Text('${data['sehir']}',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            bottom: 8,
                                            top: 5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.handshake_rounded,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 2),
                                            Text('Sahiplendirme',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              )));
                    }).toList(),
                  );
                })));
  }
}
