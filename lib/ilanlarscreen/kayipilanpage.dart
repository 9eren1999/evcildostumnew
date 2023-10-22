import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KayipIlanPage extends StatefulWidget {
  const KayipIlanPage({Key? key}) : super(key: key);

  @override
  State<KayipIlanPage> createState() => _KayipIlanPageState();
}

class _KayipIlanPageState extends State<KayipIlanPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference kayipIlan = FirebaseFirestore.instance.collection('kayipilantable');

   return Scaffold(
      appBar: AppBar(
  title: Text('Kayıp İlanları'),
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey.shade800, size: 18),
    onPressed: () {
      Navigator.pop(context); // Bu fonksiyon, kullanıcıyı bir önceki sayfaya yönlendirir.
    },
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QuerySnapshot>(
          future: kayipIlan.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 3,
  mainAxisSpacing: 9,
  children: snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Color cardColor;


      cardColor = (data['cinsiyet'] == 'Dişi') ? Colors.pinkAccent.shade100.withOpacity(0.6) : Colors.blue.shade800.withOpacity(0.6);
    

   return Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Stack(
      children: [ 
        Image.network(
          data['gorsel'],
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding( 
              padding: const EdgeInsets.only(left: 10, right:10, top: 10,),
              child: RichText( 
                text: TextSpan( 
                  children: [
                    TextSpan(
                      text: '${data['name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' (${data['yas']} aylık)',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white, thickness: 0.4,), // Divider ekledim
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8 ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.white,),
                  Text('${data['sehir']}', style: TextStyle(color: Colors.white)),  
                ],
              ),
            ),                        
            Padding(
              padding: const EdgeInsets.only(left: 8, right:8, bottom: 8, top: 5),
              child: Row(
                children: [
                  Icon(Icons.pets, size: 15, color: Colors.white,),
                  SizedBox(width: 2),
                  Text('${data['tur']}', style: TextStyle(color: Colors.white)),
                ],
        ),),
       
      ],
    ),
  ]),
));
  }).toList(),
); 
 } )));   } }   