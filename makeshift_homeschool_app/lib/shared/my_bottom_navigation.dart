import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Bottom Navigation buttons that will persist throughout the app

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentPageIndex = 0; // tracks the current selected page and highlight it

  // Change the index when a new page is selected
  void switchPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      iconSize: 20,
      selectedItemColor: Colors.greenAccent,
      currentIndex: currentPageIndex,
      items: [
        BottomNavigationBarItem(
            title: Text("Feed"),
            icon: Icon(FontAwesomeIcons.home),
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            title: Text("Post"), icon: Icon(FontAwesomeIcons.pencilAlt)),
        BottomNavigationBarItem(
            title: Text("Notifications"), icon: Icon(FontAwesomeIcons.bell)),
        BottomNavigationBarItem(
            title: Text("Profile"), icon: Icon(FontAwesomeIcons.user)),
      ].toList(),
      onTap: switchPage,
    );
  }
}
