import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Score2.dart';

int statues_score = 0;

class StatueQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Statues Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset("asset/a/AbrahamLincoln.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Important Person"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Washington Monument"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Lincoln Memorial"),
                onPressed: () {
                  statues_score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatueQuiz2()));
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
                child: Text("Abraham Lincoln"),
                onPressed: () {
                  statues_score--;
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

class StatueQuiz2 extends StatelessWidget {
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
              Image.asset("asset/a/ChristOfTheOzarks.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Christ The Redeemer"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Lady madam"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Christ Of The Ozarks"),
                onPressed: () {
                  statues_score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatueQuiz3()));
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
                  statues_score++;
                },
              ),
              RaisedButton(
                child: Text("I Wish i Had Wings"),
                onPressed: () {
                  statues_score--;
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

class StatueQuiz3 extends StatelessWidget {
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
              Image.asset("asset/a/MountRushmore.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Mount Rushmore"),
                onPressed: () {
                  statues_score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatueQuiz4()));
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
                child: Text("Rushmore Mountain"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Stone Presidents"),
                onPressed: () {
                  statues_score--;
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
                  statues_score++;
                },
              ),
              RaisedButton(
                child: Text("Inportant Faces"),
                onPressed: () {
                  statues_score--;
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

class StatueQuiz4 extends StatelessWidget {
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
              Image.asset("asset/a/StatueOfLiberty.png"),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Statue of NewYork"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Beacon of Madam Suzan"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Beacon of Liberty"),
                onPressed: () {
                  statues_score--;
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
                child: Text("Statue Of Liberty"),
                onPressed: () {
                  statues_score++;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Score2()));
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
