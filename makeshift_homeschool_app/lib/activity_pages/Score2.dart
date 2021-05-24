import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/activity_pages/statue_quiz.dart';

class Score2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Score: $statues_score"),
            RaisedButton(onPressed: () {
              statues_score = 0;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
            },
            child: Text("Done")
            )
          ],
        ),
      ),
    );
  }
}
