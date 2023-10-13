import 'package:evcildostum/anasayfascreen/anasayfapage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _selectedIndex = 2; 

  final List<Widget> pages = [
    AnasayfaPage(),
    AnasayfaPage(),  //bu sayfa isimleri güncellenirse kullanılabilir burası navbar.....:)
    AnasayfaPage(),
    AnasayfaPage(),
    AnasayfaPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: _selectedIndex == 5
    ? null
    : Container(
        height: MediaQuery.of(context).size.height * 0.08, 
        child: GNav(
          gap: 7,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          iconSize: 25,
          tabBackgroundColor: Color.fromARGB(15, 151, 64, 64),
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          color: Colors.black87,
          textSize: 15,
          activeColor: Colors.red.shade800,
          tabs: const [
            GButton(icon: Icons.library_add_rounded, text: "İlanlar"),
            GButton(icon: Icons.forum_outlined, text: "Forum"),
            GButton(icon: Icons.home_filled, text: "Anasayfa"),
            GButton(icon: Icons.comment_rounded, text: "Bloglar"),
            GButton(icon: Icons.location_on, text: "GPS Takip"),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ), );

  }
}
