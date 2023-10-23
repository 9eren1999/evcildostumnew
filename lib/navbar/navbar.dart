import 'package:evcildostum/anasayfascreen/anasayfapage.dart';
import 'package:evcildostum/blogscreen/bloglarpage.dart';
import 'package:evcildostum/forumscreen/forumpage.dart';
import 'package:evcildostum/ilanlarscreen/ilansecpage.dart';
import 'package:evcildostum/konumtakibiscreen/konumtakibipage.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class NavBarPage extends StatefulWidget {
  final bool hideNavBar;

  const NavBarPage({Key? key, this.hideNavBar = false})
      : super(key: key); 

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
      IlanlarPage(),
      ForumPage(),
      AnasayfaPage(),
      BloglarPage(),
      KonumTakibiPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.library_add_rounded, size: 21),
        inactiveIcon: Icon(Icons.library_add_rounded, size: 21),
        title: ("İlanlar"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.forum_outlined, size: 21),
        inactiveIcon: Icon(Icons.forum_outlined, size: 21),
        title: ("Forum"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_filled, size: 21),
        inactiveIcon: Icon(Icons.home_filled, size: 21),
        title: ("Anasayfa"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.comment_rounded, size: 21),
        inactiveIcon: Icon(Icons.comment_rounded, size: 21),
        title: ("Blog"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.location_on, size: 21),
        inactiveIcon: Icon(Icons.location_on, size: 21),
        title: ("GPS Takip"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey.shade800,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller!,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      onItemSelected: (int) {
        setState(() {});
      },
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style8,
      hideNavigationBar: widget.hideNavBar,
    );
  }
}
