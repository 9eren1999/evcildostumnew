import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EsDetayScreen extends StatelessWidget {
  final String documentId; // İlanın belge ID'si

  EsDetayScreen({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference ilanlar = FirebaseFirestore.instance.collection('esaramatable');

    return Scaffold(
      appBar: AppBar(
        title: Text(''), toolbarHeight: 0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: ilanlar.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('İlan bulunamadı.'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
  child: Column(
    children: [
      Stack(
        children: [ 
          Image.network(
            data['gorsel'],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 230,
          ),
          Container(
            height: 231,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Colors.black38
                ],
              ),
            ),
          ),Positioned(
                  top: 20,
                  left: 12,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
        ],
      ),
   Container(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03), // Ekran genişliğinin %5'i kadar sol padding ekler
              child: Text(
                data['name'],
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
              ),
            ), SizedBox(width: 10,),
            Text(
              data['sahip'],
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ), 
       Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.grey.shade800, size: 15,), // Şehir için farklı bir ikon kullanabilirsiniz
            Text('${data['sehir']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
          ],
             ),
       ),

        SizedBox(height: 15,),
          Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.032),
           child: Text(
            data['aciklama'], 
            textAlign: TextAlign.start, // Metin ortalandı
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                 ),
         ),
        SizedBox(height: 30), 
         
        Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // widget'ları eşit aralıklarla dağıtır
      children: [
        Row(
          children: [
            Image.asset('assets/images/yas.png', cacheHeight: 25, cacheWidth: 25),
            SizedBox(width: 5),
            Text('${data['yas']} aylık', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
          ],
        ),
        Row(
          children: [
            Image.asset('assets/images/yas.png', cacheHeight: 25, cacheWidth: 25), // Irk için farklı bir ikon kullanabilirsiniz
            SizedBox(width: 5),
            Text('${data['tur']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
          ],
        ),
        Row(
          children: [
            Image.asset('assets/images/yas.png', cacheHeight: 25, cacheWidth: 25), // Cinsiyet için farklı bir ikon kullanabilirsiniz
            SizedBox(width: 5),
            Text('${data['cinsiyet']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
          ],
        ),
      ],
    ),
    SizedBox(height: 10),
    
    SizedBox(height: 10),
    Divider(indent: 5, endIndent: 5, thickness: 0.5),
    SizedBox(height: 10),
  ],
),
  
       
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Buton işlevsiz, buraya kod ekleyerek işlevsellik sağlanabilir
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.amber.shade600, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), 
              ),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 36), // Buton genişliği ayarlandı
            ),
            child: Text('İletişime Geç'),
          ),
        ),
      ],
    ),
  ),
),
      ],
    ),
  );
  }),

  );


        }
      
    
  }

