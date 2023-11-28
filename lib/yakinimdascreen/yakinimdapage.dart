import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:evcildostum/yakinimdascreen/konumlar.dart';
import 'package:url_launcher/url_launcher.dart';

class YakinimdaPage extends StatefulWidget {
  const YakinimdaPage({Key? key}) : super(key: key);

  @override
  _YakinimdaPageState createState() => _YakinimdaPageState();
}

class _YakinimdaPageState extends State<YakinimdaPage> {
  Position? _currentUserPosition;
  List<Veteriner> _sortedVeterinerler = [];
  

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Lütfen konum servislerini etkinleştirin.');
    }

    // Konum izinlerinin durumunu kontrol et
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //eğer reddedildiyse izin iste
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //izin reddedildiyse hata göster
        return Future.error('Konum izinleri reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Konum izinleri kalıcı olarak reddedildi.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _sortVeterinerlerByDistance() {
    if (_currentUserPosition == null) {
      return;
    }

    setState(() {
      _sortedVeterinerler = yozgatVeterinerleri
        ..sort((Veteriner a, Veteriner b) {
          // İiki veteriner arasindaki mesafeyi hesaplar
          final aDistance = Geolocator.distanceBetween(
            _currentUserPosition!.latitude,
            _currentUserPosition!.longitude,
            a.enlem,
            a.boylam,
          );
          final bDistance = Geolocator.distanceBetween(
            _currentUserPosition!.latitude,
            _currentUserPosition!.longitude,
            b.enlem,
            b.boylam,
          );
          return aDistance.compareTo(bDistance);
        });
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        _currentUserPosition = position;
      });
      _sortVeterinerlerByDistance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yakınımdaki Veterinerler'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey.shade800,
            size: 19,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _currentUserPosition == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: _sortedVeterinerler.length,
              itemBuilder: (context, index) {
                // doğru veteriner değişkenini al ve _veterinerCarda geçir
                final veteriner = _sortedVeterinerler[index];
                return _veterinerCard(veteriner);
              },
            ),
    );
  }

  String formatDistance(double distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} M';
    } else {
      //kkilometreye çevir ve ondalık basamak ile format
      return '${(distance / 1000).toStringAsFixed(1)} KM';
    }
  }

  Widget _veterinerCard(Veteriner veteriner) {
    final distance = Geolocator.distanceBetween(
      _currentUserPosition!.latitude,
      _currentUserPosition!.longitude,
      veteriner.enlem,
      veteriner.boylam,
    );
    String distanceString = formatDistance(distance);

    // URL'i açacak yeni fonksiyon
    void _launchMapsUrl() async {
      final url = veteriner.mapsUrl;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Harita açılamadı $url';
      }
    }

    return Card(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
      title: Text(veteriner.isim, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade800,fontSize: 14)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(veteriner.adres, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey.shade500,fontSize: 12)),
          Text(formatDistance(distance), style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey.shade500,fontSize: 10)),
        ],
      ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Colors.grey.shade700, size: 19),
        onTap: _launchMapsUrl,
      ),
    );
  }
}
