import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:naromusic/ui/home_page/home_screen.dart';
import 'package:naromusic/ui/playlist_page/playlist_screen.dart';
import 'package:naromusic/ui/search_page/search_screen.dart';
import 'package:naromusic/ui/settings_page/settings_screen.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    
    List routes=[
      homescreen(),
      playlist_screen(),
      search_screen(),
      settings_screen()
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: routes[index],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.black,
            color: Color.fromARGB(255, 158, 155, 155),
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            onTabChange: (value) => setState(() {
              index=value;
            }),
            tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.list,
              text: "Play List",
            ),
            GButton(
              icon: Icons.search,
              text: "Search",
            ),
            GButton(
              icon: Icons.settings,
              text: "Settings",
            ),
          ]),
        ),
      ),
    );
  }
}