import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IcerikDetayPage extends StatefulWidget {
  final String documentId; // Belge ID'sini tutmak için bir değişken

  const IcerikDetayPage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<IcerikDetayPage> createState() => _IcerikDetayPageState();
}

class _IcerikDetayPageState extends State<IcerikDetayPage> {
  final CollectionReference collectionRef = FirebaseFirestore.instance.collection('bloglartable');
  

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(backgroundColor: const Color.fromARGB(0, 0, 0, 0), toolbarHeight: 0,),
    body: FutureBuilder<DocumentSnapshot>(
      future: collectionRef.doc(widget.documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('İçerik bulunamadı.'));
        }

        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          body: Stack(
  children: [
    // Görsel
    Image.network(
      data['gorsel'],
      height: MediaQuery.of(context).size.height / 2.9,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    ),

    // Geri Düğmesi
    Positioned(
  top: 20, // Düğmenin yukarıdan konumu
  left: 12, // Düğmenin soldan konumu
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
        child: Icon(Icons.arrow_back_ios_new_rounded,  color: Colors.white, size: 20),
      ),
      onPressed: () {
        Navigator.pop(context); 
      },
    ),
  ),
),

              DraggableScrollableSheet(
                initialChildSize: 0.68,
                minChildSize: 0.68,
                maxChildSize: 0.68,
                builder: (BuildContext context, myscrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: ListView(
                      controller: PrimaryScrollController.of(context) ?? myscrollController, // PrimaryScrollController kullanımı
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26, right: 26, bottom: 10, top: 25),
                          child: Text(
                            data['baslik'],
                            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.blueGrey.shade900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 26, right: 26, top: 5, bottom: 20),
                          child: Text(
                            data['yazi'],
                            style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700, fontWeight: FontWeight.w100),
                          ), 
                        ),  

                        // Alt Başlıklar ve Yazılar
                        ...List.generate(5, (index) {
                          String altbaslikKey = 'altbaslik${index+1}';
                          String yaziKey = 'yazi${index+2}';
                          if (data[altbaslikKey] != null && data[yaziKey] != null) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 26, right: 26, top: 15, bottom: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[altbaslikKey], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.blueGrey.shade900),),
                                  SizedBox(height: 10),
                                  Text(data[yaziKey], style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade700, fontWeight: FontWeight.w100),),
                                ],
                              ),
                            );
                          }
                          return Container(); // Eğer alt başlık veya yazı null ise boş bir konteyner döndür.
                        }),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical:10 ),
                          child: Text(
                            "Ekleyen: Evcil Dostum",
                            style: TextStyle(fontSize: 15, color: Colors.amber.shade600, fontWeight: FontWeight.bold),
                          ),
                        ), 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20),
                          child: Text(
                            "Etiketler: ${data['tags'] is String ? (data['tags'] as String).split(', ').join(', ') : 'Etiket Yok'}",
                            style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade800),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}



        }
     
