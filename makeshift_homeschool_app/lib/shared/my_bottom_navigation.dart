import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


/// Bottom Navigation buttons that will persist throughout the app

class MyBottomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      items: [
        BottomNavigationBarItem(
          title: Text(" "),
          icon: Icon(FontAwesomeIcons.home)
        ),
        BottomNavigationBarItem(
          title: Text(" "),
          icon: Icon(FontAwesomeIcons.book)
        ),
        BottomNavigationBarItem(
          title: Text(" "),
          icon: Icon(FontAwesomeIcons.plus)
        ),
        BottomNavigationBarItem(
          title: Text(" "),
          icon: Icon(FontAwesomeIcons.plus)
        ),
        
      ].toList(),

    );
  }
}
