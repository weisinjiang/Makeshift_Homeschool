
import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/activity_pages/statue_quiz.dart';

class Statues extends StatefulWidget {
  @override
  _StatuesState createState() => _StatuesState();
}

class _StatuesState extends State<Statues> {
  @override

  // Here is where we build the custom widget (the statue)

  Widget statue(String paint, String title, String artist, String date) {
    return Container(
        child: Row(
      children: [
        // statue
        Image.asset(
          paint,
          height: 200,
          width: 200,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Text(artist),
            Text(date)
          ],
        )
      ],
    ));
  }

  // Here is where you build out the screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statues!"),
      ),
      body: ListView(
        children: [
          statue("asset/a/StatueOfLiberty.png", "Statue of Liberty",
              "Frédéric-Auguste Bartholdi", "1889"),
          statue("asset/a/AbrahamLincoln.png", "Abraham Lincoln",
              "Daniel Chester French", "1920"),
          statue("asset/a/MountRushmore.png", "Mount Rushmore",
              "Gutzon Borglum", "1927"),
          statue("asset/a/ChristOfTheOzarks.png", "Christ of the Ozarks",
              "Emmet A. Sullivan", "1966"),
          statue("asset/a/ChristTheRedeemer.png", "Christ The Redeemer",
              "Heitor da Silva Costa", "1922"),
        ],
      ),
      drawer: Drawer(
        elevation: 16,
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("Pick a room to go to."),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("Rooms!"),
            ),
          ),
          ListTile(
            title: Text("Statue Quiz"),
            leading: Icon(Icons.image),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StatueQuiz()));
            },
          ),
          ListTile(
            title: Text("Painting"),
            leading: Icon(Icons.image),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.grey,
              height: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
