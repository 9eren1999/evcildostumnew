import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EsAramaIlanEklePage extends StatefulWidget {
  @override
  _EsAramaIlanEklePageState createState() => _EsAramaIlanEklePageState();
}

class _EsAramaIlanEklePageState extends State<EsAramaIlanEklePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _pets = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('kullanicilartable')
            .doc(user.uid)
            .get();

        for (int i = 1; i <= 4; i++) {
          String petField = 'pets';
          if (i != 1) petField = 'pets$i';

          if (userDoc[petField] != null) {
            List pets = userDoc[petField];
            _pets.addAll(pets as Iterable<Map<String, dynamic>>);
          }
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Hata: $_error'))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _pets.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Evcil hayvan seçildiğinde yapılacak işlemler
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(_pets[index]['imageUrl']),
                            radius: 40,
                          ),
                          Text(_pets[index]['name']),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
