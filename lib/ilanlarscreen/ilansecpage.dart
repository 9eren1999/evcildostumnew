import 'package:evcildostum/ilanlarscreen/esaramapage.dart';
import 'package:evcildostum/ilanlarscreen/kayipilanpage.dart';
import 'package:evcildostum/ilanlarscreen/sahiplendirmeilanpage.dart';
import 'package:flutter/material.dart';

class IlanlarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlanlar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 2.5,
          mainAxisSpacing: 7,
          children: [
            _buildGridTile(
              context,
              'assets/images/kayip.png',
              'Kayıp İlanları',
              KayipIlanPage(),
            ),
            _buildGridTile(
              context,
              'assets/images/esarama.png',
              'Eş Arama İlanları',
              EsAramaPage(),
            ),
            _buildGridTile(
              context,
              'assets/images/sahiplendirme.png',
              'Sahiplendirme İlanları',
              SahiplendirmeIlanPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile(
      BuildContext context, String imagePath, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 15,
              bottom: 15,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange.shade400.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
