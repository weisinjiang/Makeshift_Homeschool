import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activities!"),
      ),
      body: ListView(
        children: [
          RaisedButton(
              child: Text("Art Museum"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }),
        ],
      ),
    );
  }
}
