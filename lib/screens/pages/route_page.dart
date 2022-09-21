import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/screens/pages/favorite_page.dart';
import 'package:travelservices/screens/pages/home_page.dart';
import 'package:travelservices/screens/pages/profile_page.dart';
import 'package:travelservices/screens/pages/search_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    ProfilePage()
  ];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages, 
      ), 
      bottomNavigationBar: Container(
        color: bgbottombar, 
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GNav(
          onTabChange: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          tabBorderRadius: 20,
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade400,
          activeColor: Colors.white,
          tabBackgroundGradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade600,
              ],),
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search_outlined,
              text: 'Search',
            ),
            GButton(
              icon: Icons.favorite_outline,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person_outline,
              text: 'Profile',
            )
          ]
        ),
      ),
    );
  }
}