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
                  "Today we're going to draw! You are going to need some colored pencils and a regular sheet of paper.\n "),
              Image.asset("asset/activities/picture1.jpg"),
              Text(
                  " \nNow we are going to make the mountains, take a green colored pencil and draw a triangle shape like is shows in the picture.\n "),
              Image.asset("asset/activities/picture2.jpg"),
              Text(
                  " \nNext, draw another triagle and then dram a hump. After that draw the outline of the cloud.\n "),
              Image.asset("asset/activities/picture3.png"),
              Image.asset("asset/activities/picture4.jpg"),
              Text(" \nThen draw the sun you can use yellow our orange.\n "),
              Image.asset("asset/activities/picture5.jpg"),
              Text(
                  " \nDraw two wavy line's in dark blue extending wider and wider.\n "),
              Image.asset("asset/activities/picture6.jpg"),
              Text(
                  " \nAnd then color the river in with the same shade of blue.\n "),
              Image.asset("asset/activities/picture7.jpg"),
              Text(" \nfor!\n "),
              Image.asset("asset/activities/picture8.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture9.jpg"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture10.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture11.jpg"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture12.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture13.jpg"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture14.png"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture15.png"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture16.jpg"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture17.png"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture18.png"),
              Text(
                  " \nAnd lastly, turn it and fold the other flap up the other direction.\n "),
              Image.asset("asset/activities/picture19.png"),
              Text(" \nNow you are done with your paper hat!\n "),
              Image.asset("asset/activities/picture.png"),
            ],
          ),
        ));
  }
}
