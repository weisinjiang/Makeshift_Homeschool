import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'export_screens.dart'; // Access to all the screens
import '../shared/exportShared.dart';

/// Root Screen has access to every screen that is in the bottom navigation
/// Controls which page shows by using an IndexedStack and the pages index num

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentPageIndex = 0; //Home will be the first page
  static const Map<int, String> _pageNames = {
    0: "Makeshift Homeschool",
    1: "New Post",
    2: "Notifications",
    3: "Profile"
  };

  // Change the index when a new page is selected
  void switchPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var user = auth.getUserData;
    return Scaffold(
      appBar: AppBar(
        // display name based on the index paired to a name in the map
        title: Text("${_pageNames[_currentPageIndex]}"),
        backgroundColor: Colors.green[300],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.black,
        iconSize: 15,
        selectedItemColor: Colors.greenAccent,
        currentIndex: _currentPageIndex,
        items: [
          // Bottom nav screen options. Matches with the IndexedStack
          BottomNavigationBarItem(
              title: Text("Study"),
              icon: Icon(FontAwesomeIcons.bookOpen),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text("Post"),
              icon: Icon(FontAwesomeIcons.pencilAlt),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text("Notifications"),
              icon: Icon(FontAwesomeIcons.bell),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              title: Text("Profile"),
              icon: Icon(FontAwesomeIcons.user),
              backgroundColor: Colors.black),
        ].toList(),
        onTap: switchPage,
      ),
      body: IndexedStack(
        // Only 1 page of the list will show based on index
        index: _currentPageIndex, // current page displaying on screen
        children: <Widget>[
          // list of all the screens
          HomeScreen(),
          PlaceHolder(Colors.red),
          PlaceHolder(Colors.blue),
          ProfileScreen()
        ],
      ),
    );
  }
}

// Delete after all pages are done
class PlaceHolder extends StatelessWidget {
  final Color color;

  PlaceHolder(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
