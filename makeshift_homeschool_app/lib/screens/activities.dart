import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';
import 'package:makeshift_homeschool_app/activity_pages/drawing.dart';
import 'package:makeshift_homeschool_app/activity_pages/tic_tac_toe.dart';
// ignore: unused_import
import 'package:makeshift_homeschool_app/screens/root_screen.dart';

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( iconTheme: IconThemeData(color: Colors.white),
        
        backgroundColor: Colors.black,
        title: Text("Activities!", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.black87,
        child: ListView(
        children: [
          GestureDetector(
            child: Container(  
              padding: EdgeInsets.all(10),
              child: Text("Art Museum", style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
              decoration: BoxDecoration(  
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[700],
              ),
            ),
            onTap: () {
              Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Container(  
              padding: EdgeInsets.all(10),
              child: Text("Tic Tac Toe", style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
              decoration: BoxDecoration(  
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[700],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TicTacToe()));

                    },
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Container(  
              padding: EdgeInsets.all(10),
              child: Text("How to Draw a Picture", style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
              decoration: BoxDecoration(  
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[700],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DrawPicture()));
            },
          ),
        ],
      ),),
    );
  }
}
