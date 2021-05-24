import 'package:makeshift_homeschool_app/activity_pages/PaintingsQuiz.dart';
import 'package:makeshift_homeschool_app/activity_pages/Statues.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/activities.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  // Here is where we build the custom widget (the painting)

  Widget painting(String paint, String title, String artist, String date) {
    return Container(
        child: Row(
      children: [
        // Painting
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
            title: Text("Statues"),
            leading: Icon(Icons.person_outline_outlined),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Statues()));
            },
          ),
          ListTile(
            title: Text("Painting Quiz"),
            leading: Icon(Icons.question_answer_outlined),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaintingQuiz()));
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
      appBar: AppBar(
        actions: [
          FlatButton(
            color: Colors.transparent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Activities()));
              },
              child: Text("Back"))
        ],
        title: Text("Paintings!"),
      ),
      body: ListView(
        children: [
          painting("asset/a/TheStarryNight.png", "The Starry Night",
              "Vincent van Gogh", "1889"),
          painting(
              "asset/a/MonaLisa.png", "Mona Lisa", "Leonardo da Vinci", "1503"),
          painting(
              "asset/a/ASundayAfternoon.png",
              "A Sunday \nAfternoon on the\nIsland of La\n Grande Jatte",
              "Georges-Pierre Seurat",
              "1884"),
          painting("asset/a/AmericanGothic.png", "American Gothic\n",
              "Grant Wood", "1930"),
          painting("asset/a/Rain'sRustle.png", " Rain's Rustle",
              "Leonid Afremov's", "2010"),
          painting("asset/a/TheChurchAtAmsterdam.png",
              "The Church At\n  Amsterdam", "Vincent van Gogh", "1884"),
          painting("asset/a/MountainRetreat.png", "Mountain Retreat",
              "Bob Ross", "1984"),
        ],
      ),
    );
  }
}
