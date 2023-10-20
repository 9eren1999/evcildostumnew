import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BloglarPage extends StatefulWidget {
  const BloglarPage({Key? key}) : super(key: key);

  @override
  State<BloglarPage> createState() => _BloglarPageState();
}

class _BloglarPageState extends State<BloglarPage> {
  final CollectionReference collectionRef = FirebaseFirestore.instance.collection('bloglartable');
  final CollectionReference tagsRef = FirebaseFirestore.instance.collection('tags');
  String? selectedTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloglar'),
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: tagsRef.doc('jzOhXK8B0yTJ3SIAtkGH').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              Map<String, dynamic> tags = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['Tümü', ...tags.values].map((tag) {
                    bool isSelected = selectedTag == tag || (selectedTag == null && tag == 'Tümü');
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTag = tag == 'Tümü' ? null : tag;
                        });
                      },
                      child: Padding( 
                        padding: const EdgeInsets.symmetric( vertical: 8.0),
                        child: Card(
                          color: isSelected ? Colors.blue : Colors.orange, // Seçilen kategori mavi, diğerleri turuncu
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Kartın köşelerini yuvarla
                          ),
                          child: Padding( 
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
                            child: Text(  
                              tag,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: collectionRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                    if (selectedTag != null && data['tags'] != selectedTag) return Container();

                    return Padding(
  padding: const EdgeInsets.all(12.0),
  child: InkWell(
    onTap: () {
      // Card'a tıklandığında gerçekleştirilecek aksiyon
    },
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(data['gorsel']),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, top: 7, left: 15, bottom: 7),
            child: Text(
              data['baslik'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['yazi'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Devamını oku düğmesine tıklandığında gerçekleştirilecek aksiyon
                    },
                    child: Text("Devamını Oku..."),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
            }).toList(),
          );
        },
      ),
    )]));
  }
}
