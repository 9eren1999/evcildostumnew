import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DestekSistemiPage extends StatefulWidget {
  @override
  _DestekSistemiPageState createState() => _DestekSistemiPageState();
}

class _DestekSistemiPageState extends State<DestekSistemiPage> {
  final _formKey = GlobalKey<FormState>();
  final CollectionReference destekSistemiTable =
      FirebaseFirestore.instance.collection('desteksistemitable');
  final CollectionReference kullanicilarTable =
      FirebaseFirestore.instance.collection('kullanicilartable');

  late String _konu;
  late String _mesaj;

  get data => null;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: screenSize.height * 0.5,
              color: Colors.orange,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenSize.height * 0.5,
              color: Colors.white,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/desteksistemiasset.png',
                              fit: BoxFit
                                  .fitHeight, //resmi containera sığacak şekilde ayarlıyo
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: kullanicilarTable.doc(user?.uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (!snapshot.hasData || snapshot.data == null) {
                              return Text("Kullanıcı bilgisi yüklenemedi.");
                            }

                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            if (data['isim'] == null ||
                                data['soyisim'] == null) {
                              return Text(
                                  "Kullanıcı ismi veya soyismi mevcut değil.");
                            }

                            return Column(
                              children: [
                                Text('${data['isim']} ${data['soyisim']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('${user?.email ?? 'Email bilgisi yok'}'),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Konu',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(
                                child: Text('Teknik Sorunlar'),
                                value: 'Teknik Sorunlar'),
                            DropdownMenuItem(
                                child: Text('Üyelik ve Hesap'),
                                value: 'Üyelik ve Hesap'),
                            DropdownMenuItem(
                                child: Text('İz İzleyici Tasma'),
                                value: 'İz İzleyici Tasma'),
                            DropdownMenuItem(
                                child: Text('Güvenlik'), value: 'Güvenlik'),
                            DropdownMenuItem(
                                child: Text('Öneri ve Geri Bildirim'),
                                value: 'Öneri ve Geri Bildirim'),
                            DropdownMenuItem(
                                child: Text('Diğer'), value: 'Diğer'),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _konu = value.toString();
                            });
                          },
                          validator: (value) {
                            if (value == null) return 'Bir konu seçiniz';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mesaj',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value!.isEmpty) return 'Mesaj giriniz';
                            return null;
                          },
                          onSaved: (value) => _mesaj = value!,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              DocumentSnapshot userDoc =
                                  await kullanicilarTable.doc(user?.uid).get();
                              Map<String, dynamic> userData =
                                  userDoc.data() as Map<String, dynamic>;

                              if (userData['isim'] != null &&
                                  userData['soyisim'] != null) {
                                await destekSistemiTable.add({
                                  'isimSoyisim':
                                      '${userData['isim']} ${userData['soyisim']}',
                                  'email': user?.email,
                                  'konu': _konu,
                                  'mesaj': _mesaj,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Mesajınız gönderildi.'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Kullanıcı bilgisi alınamadı.'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text('Gönder'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.005,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
