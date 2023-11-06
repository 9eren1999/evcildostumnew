import 'dart:math';
import 'package:evcildostum/isimonericiscreen/fonksiyonlarveparametreler.dart';
import 'package:flutter/material.dart';

class IsimOnericiPage extends StatefulWidget {
  @override
  _IsimOnericiPageState createState() => _IsimOnericiPageState();
}

class _IsimOnericiPageState extends State<IsimOnericiPage> {
  String? secilenTur;
  String? secilenCinsiyet;
  List<String> isimListesi = [];
  final int _isimSayisi = 10; 
  bool isimOnerildi = false;
  List<Map<String, String>> detailedIsimListesi = [];
  int _suankiIsimSayisi = 0;

 void isimOner() {
  setState(() {
    if (secilenTur != null && secilenCinsiyet != null) {
      final possibleNames = isimler[secilenTur]?[secilenCinsiyet];

      if (possibleNames != null && detailedIsimListesi.length < possibleNames.length) {
        var namesToAdd = min(30 - detailedIsimListesi.length, possibleNames.length - detailedIsimListesi.length);
        detailedIsimListesi.addAll(possibleNames.sublist(detailedIsimListesi.length, detailedIsimListesi.length + namesToAdd));
      }
    }
  });
}
   void resetFilters() {
  setState(() {
    isimOnerildi = false;
    secilenTur = null;
    secilenCinsiyet = null;
    isimListesi.clear();
    detailedIsimListesi.clear();
    _suankiIsimSayisi = 0; 
  });
}


  Widget buildCardChoice(String title, List<String> options, String? selectedValue, Function(String?) onSelected) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            children: options.map((option) => Padding(
              padding: EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(option),
                selected: selectedValue == option,
                onSelected: (selected) {
                  onSelected(selected ? option : null);
                },
                selectedColor: Colors.orange,
                backgroundColor: Colors.grey.withOpacity(0.18),
                labelStyle: TextStyle(color: Colors.black),
              ),
            )).toList(),
            spacing: 8.0,
            runSpacing: -12.0,
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İsim Önericisi',
              style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
         leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_rounded ,color: Colors.grey.shade800, size: 19,),
    onPressed: () {
      Navigator.of(context).pop(); // Bir önceki sayfaya döner
    },
  ),
        actions: [
          if (isimOnerildi) // İsim önerildiğinde yeniden filtrele butonunu göster
            TextButton(
              onPressed: resetFilters,
              child: Text('Yeniden Filtrele', style: TextStyle(color: Colors.orange),),
            ),
        ],
      ),
      body: isimOnerildi ? buildIsimOnerildiView() : buildFilterView(),
    );
  }

 Widget buildFilterView() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: buildCardChoice(
                    'Hayvan Türü', ['Kedi', 'Köpek'], secilenTur, (val) {
                  setState(() => secilenTur = val);
                }),
              ),
              SizedBox(width: 12), 
              Expanded(
                child: buildCardChoice(
                    'Cinsiyet', ['Erkek', 'Dişi'], secilenCinsiyet, (val) {
                  setState(() => secilenCinsiyet = val);
                }),
              ),
            ],
          ),
          SizedBox(height: 18),
          SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    ),
   onPressed: secilenTur != null && secilenCinsiyet != null 
  ? () {
      setState(() {
        isimOnerildi = true;
        isimOner(); 
      });
    }
  : null,
child: Text('İsimleri Listele', style: TextStyle(fontSize: 16)),
        ))],
      ),
    ),
  );
}

  Widget buildIsimOnerildiView() {
  return Column(
    children: [
      if (detailedIsimListesi.isNotEmpty)
        Expanded(
          child: ListView.separated(
            itemCount: detailedIsimListesi.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade400),
            itemBuilder: (context, index) {
              var nameInfo = detailedIsimListesi[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Text(
                  nameInfo['isim'] ?? 'Unknown',
                  style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  nameInfo['aciklama'] ?? 'No description available.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              );
            },
          ),
        ),
        
      if (isimListesi.isNotEmpty && isimListesi.length < 30)
        Padding(
          padding: EdgeInsets.all(4.0),
          child: TextButton(
            onPressed: isimOner,
            child: Text('Daha Fazla Yükle', style: TextStyle(color: Colors.grey.shade900)),
          ),
        ),
    ],
  );
}}