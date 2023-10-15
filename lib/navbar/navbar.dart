import 'package:evcildostum/anasayfascreen/anasayfapage.dart';
import 'package:evcildostum/girisyapscreen/girisyappage.dart';
import 'package:evcildostum/kayitolscreen/2ekhayvan.dart';
import 'package:evcildostum/kayitolscreen/kayitolpage.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// CustomNavBarWidget kodunuz buraya gelmeli.

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  List<Widget> _buildScreens() {
    return [
      KayitOlPage(),
      GirisYapPage(),
      AnasayfaPage(),
      EkHayvanEklePage(),
      AnasayfaPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.library_add_rounded, size: 21),
        inactiveIcon: Icon(Icons.library_add_rounded, size: 21), // boyutu ayarladık
        title: ("İlanlar"), 
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.forum_outlined, size: 21),
        inactiveIcon: Icon(Icons.forum_outlined, size: 21), // boyutu ayarladık
        title: ("Forum"), 
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_filled, size: 21),
        inactiveIcon: Icon(Icons.home_filled, size: 21), // boyutu ayarladık
        title: ("Anasayfa"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.comment_rounded, size: 21),
        inactiveIcon: Icon(Icons.comment_rounded, size: 21), // boyutu ayarladık
        title: ("Bloglar"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.location_on,  size: 21),
        inactiveIcon: Icon(Icons.location_on,  size: 21), // boyutu ayarladık
        title: ("GPS Takip"),
        activeColorPrimary: Colors.amber,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
    ];
  }

   @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, // <-- Bu satırdaki değişiklik.
      controller: _controller!,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      onItemSelected: (int) {
        setState(() {}); // Yeni seçilen tab ile güncellemek için.
      },
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style8, // Tarzı bu şekilde seçebilirsiniz.
    );
  }
}
