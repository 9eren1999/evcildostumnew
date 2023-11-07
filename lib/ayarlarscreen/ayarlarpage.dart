import 'package:evcildostum/dostlarimscreen/dostlarimpage.dart';
import 'package:evcildostum/profilscreen/profilpage.dart';
import 'package:flutter/material.dart';

class AyarlarPage extends StatefulWidget {
  const AyarlarPage({Key? key}) : super(key: key);

  @override
  _AyarlarPageState createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  bool isUygulamaBildirimleriOn = true;
  bool isMailBildirimleriOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.grey.shade800, size: 19,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [ SizedBox(height: 5,),
          ListTile(
            title: Text('Hesaplar' ,style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900,)),
            subtitle: Text(
              'Kişisel hesabını ya da evcil hayvan profillerini düzenle',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ListTile(
            title: Text('Profilim'),
            trailing: Icon(Icons.arrow_forward_ios,  color: Colors.grey.shade800, size: 18,),
            onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()), 
              );
            },
          ),
          ListTile(
            title: Text('Evcil Hayvan Profillerim'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade800, size: 18,),
            onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DostlarimPage()), 
              );
            },
          ),SizedBox(height: 10,), Divider(), SizedBox(height: 10,), 
          ListTile(
            title: Text('Bildirim ve İletişim' ,style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
            subtitle: Text(
              'Uygulama bildirimlerini ve iletişim yöntemlerini kontrol et',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          SwitchListTile(
            title: Text('Uygulama Bildirimleri'),
            value: isUygulamaBildirimleriOn,
            onChanged: (bool newValue) {
              setState(() {
                isUygulamaBildirimleriOn = newValue;
              });
            },
          ),
          SwitchListTile(
            title: Text('Mail Bildirimleri'),
            value: isMailBildirimleriOn,
            onChanged: (bool newValue) {
              setState(() {
                isMailBildirimleriOn = newValue;
              });
            },
          ), SizedBox(height: 10,), Divider(), SizedBox(height: 10,), 
          ListTile(
            title: Text('Şartlar ve Koşullar' ,style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
            subtitle: Text(
              'Uygulama hakları, veri işleme ve sınırlandırmaları keşfet',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),

          ListTile(
            title: Text('Gizlilik Sözleşmesi'),
          ),

          ListTile(
            title: Text('Kullanıcı Sözleşmesi'),
          ),

          ListTile(
            title: Text('Kullanım Koşulları'),
          ),
        ],
      ),
    );
  }
}
