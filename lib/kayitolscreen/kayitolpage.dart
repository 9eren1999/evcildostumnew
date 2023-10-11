import 'package:evcildostum/girisyapscreen/girisyappage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class KayitOlPage extends StatefulWidget {
  @override
  State<KayitOlPage> createState() => _KayitOlPageState();
}

class _KayitOlPageState extends State<KayitOlPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email;
  String? _sifre;
  String? _isim;
  String? _soyisim;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.red.shade600,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.white10,
            ),
          ),
          Center( 
            child: SingleChildScrollView(
              child: Container( 
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.red.shade600),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ), margin: EdgeInsets.only(top: 40, bottom: 40), 
                width: MediaQuery.of(context).size.width * 0.85,
                
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _isLoading
                      ? Center(
                          child: Lottie.asset(
                              'assets/animations/loading_animation.json',
                              width: 150,
                              height: 150))
                      : Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Lottie.asset(
                                'assets/animations/registeranimasyon.json',
                                height: 200,
                              ),
                              SizedBox(height: 20),
                              Text('Kayıt Ol',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Ad',
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) return 'Adınızı giriniz';
                                  return null;
                                },
                                onSaved: (value) => _isim = value!,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Soyad',
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'Soyadınızı giriniz';
                                  return null;
                                },
                                onSaved: (value) => _soyisim = value!,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) return 'Email giriniz';
                                  return null;
                                },
                                onSaved: (value) => _email = value!,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Şifre',
                                    border: OutlineInputBorder()),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) return 'Şifre giriniz';
                                  return null;
                                },
                                onSaved: (value) => _sifre = value!,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Şifre Tekrar',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'Şifre tekrarını giriniz';
                                  if (_sifre != null && value != _sifre)
                                    return 'Şifreler eşleşmiyor';
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    //_email ve _sifrenin null olup olmadığını kontrol ediyoruz
                                    if (_email != null && _sifre != null) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      try {
                                        UserCredential userCredential =
                                            await _auth
                                                .createUserWithEmailAndPassword(
                                          email: _email!,
                                          password: _sifre!,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Kayıt başarılı Giriş yap sayfasına yönlendiriliyorsunuz: ${userCredential.user!.uid}"),
                                          ),
                                        );

                                        final CollectionReference
                                            kullanicilartable =
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'kullanicilartable');
                                        kullanicilartable
                                            .doc(userCredential.user!.uid)
                                            .set({
                                          'email': _email,
                                          'isim': _isim,
                                          'soyisim': _soyisim,
                                        });

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GirisYapPage()),
                                        );
                                      } catch (e) {
                                        print("Kayıt hatası: $e");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Hata: $e"),
                                          ),
                                        );
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Email veya şifre eksik!"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text('Kayıt Ol'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red.shade600),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GirisYapPage()),
                                  );
                                },
                                child: Text(
                                  'Zaten Hesabın var mı? Giriş Yap',
                                  style: TextStyle(color: Colors.red.shade600),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
