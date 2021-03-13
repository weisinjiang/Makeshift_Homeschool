import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/Activities/drawpicture.dart';
import 'package:makeshift_homeschool_app/Activities/paperhat.dart';
import 'package:makeshift_homeschool_app/Activities/tictactoe.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Color(0xFF192A56),
        title: Text(
          "Activities!",
          style: TextStyle(color: Colors.white),
        ),
      ),
        body: Container(
          color: Colors.white,
          child: ListView(children: [
      Container(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Color(0xFF192A56),
            child: InkWell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Tic Tac Toe", style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TicTacToe()));
              },
            ),
          )),
          Container(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Color(0xFF192A56),
            child: InkWell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("How to make a paper hat", style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaperHat()));
              },
            ),
          )),Container(
          padding: EdgeInsets.all(10),
          child: Card(
            color: Color(0xFF192A56),
            child: InkWell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("How to draw a picture", style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DrawPicture()));
              },
            ),
          ))
    ])));
  }
}
