import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  String? username;
  bool _isLoading = false;
  bool showAllComments = false;
  Map<String, TextEditingController> _commentControllers = {};
  String? expandedPostId; // Hangi postun yorumları genişletildiğini takip eder

  int shownCommentsLimit = 1;
  String currentUsername =
      "KullanicininAdi"; 

  String? selectedImagePath;

  //TextEditingController _usernameController = TextEditingController();
  TextEditingController _postController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    kullaniciBilgileriniYukle();
  }

  Future<void> kullaniciBilgileriniYukle() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('kullanicilartable')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        var userInfo = userDoc.data() as Map<String, dynamic>;
        username = '${userInfo['isim']} ${userInfo['soyisim']}';
      });
    }
  }

  TextEditingController getCommentController(String postId) {
    if (!_commentControllers.containsKey(postId)) {
      _commentControllers[postId] = TextEditingController();
    }
    return _commentControllers[postId]!;
  }

  Future<QuerySnapshot> getForumData() async {
    QuerySnapshot snapshot = await _firestore
        .collection('forum')
        .orderBy('eklenme_tarihi', descending: true)
        .get(GetOptions(source: Source.cache));

    if (snapshot.docs.isEmpty) {
      snapshot = await _firestore
          .collection('forum')
          .orderBy('eklenme_tarihi', descending: true)
          .get(GetOptions(source: Source.server));
    }

    return snapshot;
  }

  Future<List<Map<String, dynamic>>> getYorumlarVeKullaniciBilgileri(
      String postId) async {
    List<Map<String, dynamic>> yorumlar = [];
    var yorumSnapshot = await _firestore
        .collection('forum')
        .doc(postId)
        .collection('yorumlar')
        .get();

    for (var yorum in yorumSnapshot.docs) {
      String yorumYapanUuid =
          yorum.data()['yorumYapanUuid']; 

      var kullaniciDoc = await FirebaseFirestore.instance
          .collection('kullanicilartable')
          .doc(yorumYapanUuid)
          .get();
      String username = kullaniciDoc.exists
          ? "${kullaniciDoc.data()?['isim']} ${kullaniciDoc.data()?['soyisim']}"
          : "Bilinmeyen Kullanıcı";

      yorumlar.add({
        ...yorum.data(),
        'username': username,
      });
    }

    return yorumlar;
  }

  Widget _buildCommentWidget(String postId, Map<String, dynamic> comment) {
    String username = comment['username'] ?? 'Bilinmeyen Kullanıcı';
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  username, // Null kontrolü ile kullanıcı adı ve soyadı
                  style: TextStyle(fontSize: 10, color: getRandomColor()),
                ),
              ),
            ],
          ),
          subtitle: Text(
            comment['text'],
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
        Divider(color: Colors.black26, height: 1.0, thickness: 0.3),
      ],
    );
  }

  void _showImageFullScreen(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // resme tekrar tiklandığında diyaloğu kapat
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  void _showPostedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange.shade600,
          title: Text(
            "Gönderin Paylaşıldı",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Paylaşılan gönderilerin tamamı editörlerimiz tarafından düzenli olarak kontrol edilmektedir. Eğer platform kurallarımıza uymadığını düşündüğümüz bir içerik paylaştıysan, sana haber vermeden gönderini kaldırırız.",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam", style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }

  Future<String?> uploadImage(File imageFile, String storagePath) async {
    final storageReference = FirebaseStorage.instance.ref().child(storagePath);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
    String? downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl; //Bu kısım önemli. Görselin URL'sini döndürmeli.
  }

  void toggleComments(String postId) {
    if (expandedPostId == postId) {
      //postun yorumları zaten genişletilmişse genişletmeyi kapat
      setState(() {
        expandedPostId = null;
      });
    } else {
      //postun yorumları genişletilmemişse genişlet
      setState(() {
        expandedPostId = postId;
      });
    }
  }

  Future<void> deleteComment(
      String postId, Map<String, dynamic> comment) async {
    try {
      await _firestore.collection('forum').doc(postId).update({
        'comments': FieldValue.arrayRemove([comment]),
        'commentCount': FieldValue.increment(-1) 
      });
    } catch (error) {
      print("Error deleting comment: $error");
    }
  }

  void _showPostInput(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          Future<void> _selectImage() async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              setModalState(() {
                selectedImagePath = pickedFile.path;
              });
            } else {
              print('Görsel seçilmedi.');
            }
          }

          return Container(
            height: (screenHeight * 9) / 10,
            padding: EdgeInsets.all(15.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // elemanları en başta ve sonda tutar
                children: [
                  IconButton(
                    icon: Icon(Icons.add_a_photo, color: Colors.blue.shade800),
                    onPressed: _selectImage,
                    splashColor: Colors.blue,
                  ),
                  Text(
                    "Yeni Gönderi Oluştur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_postController.text.length > 0) // Kontrol
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.blue.shade800),
                      onPressed: () {
                        _addPostToFirebase();
                        Navigator.pop(context);
                        _showPostedDialog(context);
                      },
                    )
                  else
                    SizedBox(
                      width: 48,
                    ) 
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _postController,
                onChanged: (value) {
                  setModalState(() {}); 
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Aklına takılan bir şey mi var? Hemen sor...',
                  hintStyle: TextStyle(fontSize: 12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue.shade800), 
                  ),
                ),
                maxLines: null,
              ),
              if (selectedImagePath != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.file(
                    File(selectedImagePath!),
                    height: 100, 
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 10),
            ]),
          );
        });
      },
    );
  }

  Future<void> addComment(String postId, String commentText) async {
    setState(() {
      _isLoading = true; 
    });

    if (commentText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Yorum boş olamaz!"),
        backgroundColor: Colors.blue.shade800,
      ));
      setState(() {
        _isLoading = false; // Yüklenme durduruldu
      });
      return;
    }

    Map<String, dynamic> newComment = {
      'text': commentText,
      'timestamp': Timestamp.now(),
      'username': username,
      'postId': postId,
      'isEdited': false
    };

    try {
      // Firebase'e yorum ekleme işlemini gerçekleştir
      await _firestore.collection('forum').doc(postId).update({
        'comments': FieldValue.arrayUnion([newComment]),
        'commentCount': FieldValue.increment(1) //Yorum sayısını artır
      });

      getCommentController(postId).clear(); 
    } catch (error) {
      //Hata oluştuğunda 
      print("Error adding comment: $error");
    } finally {
      setState(() {
        _isLoading = false; 
      });
    }
  }

  void _showDeleteConfirmationDialog(DocumentSnapshot data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gönderiyi sil?'),
          content: Text('Bu gönderiyi silmek istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () async {
                await _firestore.collection('forum').doc(data.id).delete();
                Navigator.of(context).pop();
                setState(() {
                  //gönderi listesini yeniden yükleyebiliriz
                });
              },
            ),
          ],
        );
      },
    );
  }

  /*Future<void> _showDeleteCommentDialog(
      String postId, Map<String, dynamic> commentData) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yorumu Sil'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bu yorumu silmek istediğinize emin misiniz?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sil'),
              onPressed: () async {
                await deleteComment(postId, commentData);
                Navigator.of(context).pop();
                setState(() {
                  //yorum listesini yeniden yükleyebiliriz
                });
              },
            ),
          ],
        );
      },
    );
  }
*/
  Color getRandomColor() {
    final random = Random();

    List<Color> colors = [
      Colors.green.shade500,
      Colors.yellow.shade900,
      Colors.yellow.shade800,
      Colors.red.shade900,
      Colors.red.shade300,
      Colors.cyan.shade900,
      Colors.cyan.shade400,
      Colors.pink.shade600,
      Colors.orange.shade700,
      Color.fromARGB(255, 165, 71, 182),
      Colors.lime.shade900,
      Colors.amber.shade700,
      Colors.blue.shade500,
      Colors.blueGrey,
      Colors.blue.shade900,
      Colors.indigo.shade500,
      Colors.deepOrange.shade900,
    ];

    return colors[random.nextInt(colors.length)];
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return '1 dakika önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 365) {
      int months = difference.inDays ~/ 30;
      return '$months ay önce';
    } else {
      int years = difference.inDays ~/ 365;
      return '$years yıl önce';
    }
  }

  Future<int> getTotalComments(String postId) async {
    var document = await _firestore.collection('forum').doc(postId).get();
    List comments = document.data()?['comments'] ?? [];
    return comments.length;
  }

  Future<void> _addPostToFirebase() async {
    if (_postController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String? resimUrl;

      if (selectedImagePath != null) {
        //görseli Storage'a yükle
        String storagePath = "forum_images/${DateTime.now().toIso8601String()}";
        resimUrl = await uploadImage(File(selectedImagePath!), storagePath);
      }

      try {
        await _firestore.collection('forum').add({
          'adsoyad': username,
          'aciklama': _postController.text,
          'eklenme_tarihi': DateTime.now().toIso8601String(),
          'resimUrl':
              resimUrl, //Eğer bir görsel seçilmediyse, bu alan null olacak.
        });

        _postController.clear();

        setState(() {
          selectedImagePath = null;
        });
      } catch (e) {
        print("Hata oluştu: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _loadingIndicator() {
    if (!_isLoading) return SizedBox.shrink();
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade800))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 250, 0.959),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Color.fromARGB(255, 255, 255, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Geri butonu
                  Padding(
                    padding: const EdgeInsets.only(top: 25, right: 16),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 10), 
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          "Evcil Dostum Forum",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // İconlar için bir Row oluşturduk.
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey.shade800,
                          ),
                          onPressed: () {
                            _showPostInput(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<QuerySnapshot>(
                      future: getForumData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            var postId = snapshot.data!.docs[index].id;
                            bool hasImageUrl =
                                (data.data() as Map<String, dynamic>)
                                    .containsKey('resimUrl');

                            return Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: Material(
                                      elevation: 0, // Gölgenin yüksekliği
                                      shadowColor: Colors
                                          .blue.shade800, // Gölgenin rengi
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            2.0), 
                                      ),
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${data['adsoyad']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      timeAgo(DateTime
                                                                          .parse(
                                                                              data['eklenme_tarihi'])),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    if (data[
                                                                            'adsoyad'] ==
                                                                        username)
                                                                      Container(
                                                                        height:
                                                                            16.0,
                                                                        child:
                                                                            IconButton(
                                                                          padding:
                                                                              EdgeInsets.zero, 
                                                                          icon: Icon(
                                                                              Icons.delete,
                                                                              size: 17,
                                                                              color: Colors.black),
                                                                          onPressed:
                                                                              () {
                                                                            _showDeleteConfirmationDialog(data);
                                                                          },
                                                                        ),
                                                                      ),
                                                                  ]),
                                                            ],
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      data[
                                                                          'aciklama'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w100,
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            2),
                                                                    if (hasImageUrl &&
                                                                        data['resimUrl'] !=
                                                                            null)
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          _showImageFullScreen(
                                                                              context,
                                                                              data['resimUrl']);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 1.0),
                                                                          child:
                                                                              Image.network(
                                                                            data['resimUrl'],
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                double.infinity,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    Divider(
                                                                      thickness:
                                                                          0.2,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    StreamBuilder<
                                                                        DocumentSnapshot>(
                                                                      stream: _firestore
                                                                          .collection(
                                                                              'forum')
                                                                          .doc(
                                                                              postId)
                                                                          .snapshots(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return SizedBox
                                                                              .shrink();
                                                                        }
                                                                        var postDocument =
                                                                            snapshot.data!;
                                                                        Map<String,
                                                                                dynamic>?
                                                                            postData =
                                                                            postDocument.data()
                                                                                as Map<String, dynamic>?;

                                                                        if (postData ==
                                                                                null ||
                                                                            !postData.containsKey('comments')) {
                                                                          return SizedBox
                                                                              .shrink();
                                                                        }

                                                                        List<dynamic>
                                                                            comments =
                                                                            postData['comments'] ??
                                                                                [];

                                                                        double
                                                                            containerHeight;
                                                                        if (comments.length <=
                                                                            4) {
                                                                          containerHeight =
                                                                              comments.length * 100.0; 
                                                                        } else {
                                                                          containerHeight =
                                                                              340.0; 
                                                                        }

                                                                        return Container(
                                                                          height:
                                                                              containerHeight,
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: comments.map((comment) {
                                                                                return _buildCommentWidget(postId, comment);
                                                                              }).toList(),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    Divider(
                                                                      color: Colors
                                                                          .black45,
                                                                      height:
                                                                          1.0,
                                                                      thickness:
                                                                          0.5,
                                                                    ),
                                                                    TextField(
                                                                      controller:
                                                                          getCommentController(
                                                                        postId,
                                                                      ),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Yorum yap...',
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.6),
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                        suffixIcon: IconButton(
                                                                            icon: Icon(Icons.send, color: Colors.black),
                                                                            onPressed: () {
                                                                              if (_commentControllers.containsKey(postId)) {
                                                                                addComment(postId, _commentControllers[postId]!.text);
                                                                                _commentControllers[postId]!.clear();
                                                                              }
                                                                            }),
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: Color.fromARGB(
                                                                                62,
                                                                                255,
                                                                                255,
                                                                                255),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]))
                                                        ]))
                                              ]))))
                            ]);
                          },
                        );
                      },
                    ),
                  ),

                  _loadingIndicator(), // Burada _loadingIndicator fonksiyonunu çağırıyoruz
                ],
              ),
            )
          ],
        ));
  }
}
