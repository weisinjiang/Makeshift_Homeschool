import 'package:flutter/material.dart';

class DrawPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "How To Draw A Picture",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF192A56),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                  "Today we're going to make a paper hat! You are going to need a regular piece of paper.\n "),
              Image.asset("asset/activities/picture1.jpg"),
              Text(" \nNow, take your piece of paper and fold it in half.\n "),
              Image.asset("asset/activities/picture2.jpg"),
              Text(
                  " \nNext, fold the corners into the middle until they touch.\n "),
              Image.asset("asset/activities/picture3.png"),
              Text(" \nThen, fold one of the bottom flaps up.\n "),
              Image.asset("asset/activities/picture4.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture7.jpg"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture8.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture5.jpg"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture6.jpg"),
            ],
          ),
        ));
  }
}
