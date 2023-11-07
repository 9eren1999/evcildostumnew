import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class KonumTakibiPage extends StatefulWidget {
  @override
  _KonumTakibiPageState createState() => _KonumTakibiPageState();
}

class _KonumTakibiPageState extends State<KonumTakibiPage> {
  BitmapDescriptor? customMarker;
  bool fullScreen = false;
  LatLng? markerLocation;
  String selectedAnimal = 'akita';

  @override
  void initState() {
    super.initState();
    fetchLocationFromFirestore();
    setCustomMarker();
  }

  void fetchLocationFromFirestore() async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('konumtable')
        .doc('PzadX6oj0KsVOAaiSl1L')
        .get();

    final String locationString = doc['konumverisi'];
    final List<String> locationComponents = locationString.split(', ');

    setState(() {
      markerLocation = LatLng(
        double.parse(locationComponents[0]),
        double.parse(locationComponents[1]),
      );
    });
  }

  void setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(150, 150)), 'assets/images/marker.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          markerLocation == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: markerLocation!,
                    zoom: 14.4746,
                  ),
                  markers: {
                    if (customMarker != null && markerLocation != null)
                      Marker(
                        markerId: MarkerId('id-1'),
                        position: markerLocation!,
                        icon: customMarker!,
                      ),
                  },
                ),
          Positioned(
            left: 10,
            top: 50,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedAnimal,
                  items: [
                    DropdownMenuItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/akita.png'),
                                  radius: 15,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Bulut',
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      value: 'akita',
                    ),
                    // diğer hayvanlar için dropdownmenuItem
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      selectedAnimal = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
