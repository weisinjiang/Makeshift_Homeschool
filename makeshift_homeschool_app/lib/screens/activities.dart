import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/Activities/tictactoe.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget activity(String activity) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Card(
          color: Colors.grey[300],
          child: InkWell(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("${activity}", style: TextStyle(fontSize: 25)),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TicTacToe()));
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Activities!"),
      ),
      body: Container(
        color: Colors.brown[200],
        child: ListView(
          children: [
            activity("tic tac toe"),
          ],
        ),
      ),
    );
  }
}
