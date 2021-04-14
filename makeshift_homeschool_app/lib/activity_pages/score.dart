import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';
import 'package:flutter/material.dart';
import 'PaintingsQuiz.dart';

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Score: $score"),
            RaisedButton(onPressed: () {
              score = 0;
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
