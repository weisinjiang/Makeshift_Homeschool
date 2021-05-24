import 'package:makeshift_homeschool_app/activity_pages/art_museum_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/activity_pages/score.dart';

int score = 0;

class PaintingQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paintings Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset("asset/a/MonaLisa.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Mona Lilly"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Woman"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Mona Lisa"),
                onPressed: () {
                  score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaintingQuiz2()));
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('Correct!'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Lady Suzan"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              )
            ],
          ),
        ));
  }
}

//! SECOND QUESTION

class PaintingQuiz2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paintings Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset("asset/a/MountainRetreat.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Water fall View"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Lady Suzan"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Mountain Retreat"),
                onPressed: () {
                  score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaintingQuiz3()));
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('Correct!'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                  score++;
                },
              ),
              RaisedButton(
                child: Text("River Retreat"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              )
            ],
          ),
        ));
  }
}

//! THIRD QUESTION

class PaintingQuiz3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paintings Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset("asset/a/Rain'sRustle.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Rain's Rustle"),
                onPressed: () {
                  score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaintingQuiz4()));
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are correct.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Lady Suzan"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Mountain Retreat"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                  score++;
                },
              ),
              RaisedButton(
                child: Text("Falling Rain"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              )
            ],
          ),
        ));
  }
}
//! FOURTH QUESTION

class PaintingQuiz4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paintings Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset("asset/a/TheStarryNight.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Night City"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Moon and Star"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("Starry Night"),
                onPressed: () {
                  score--;
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('incorrect'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              RaisedButton(
                child: Text("The Starry Night"),
                onPressed: () {
                  score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Score()));
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                            title: Text('You are correct!.'),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('Close'),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              )
            ],
          ),
        ));
  }
}
