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
              Image.asset("asset/a/drawing/picture1.jpg"),
              Text(
                  " \nNow we are going to make the mountains, take a green colored pencil and draw a triangle shape like is shows in the picture.\n "),
              Image.asset("asset/a/drawing/picture2.jpg"),
              Text(
                  " \nNext, draw another triagle and then draw a hump as a hill. After that draw the outline of the cloud.\n "),
              Image.asset("asset/a/drawing/picture3.jpg"),
              Image.asset("asset/a/drawing/picture4.jpg"),
              Text(" \nThen draw the sun you can use yellow our orange.\n "),
              Image.asset("asset/a/drawing/picture5.jpg"),
              Text(
                  " \nDraw two wavy line's in dark blue extending wider and wider.\n "),
              Image.asset("asset/a/drawing/picture6.jpg"),
              Text(
                  " \nAnd then color the river in with the same shade of blue.\n "),
              Image.asset("asset/a/drawing/picture7.jpg"),
              Text(
                  " \nfor the tree draw two brown lines that extend outward at the ends.\n "),
              Image.asset("asset/a/drawing/picture8.jpg"),
              Text(
                  " \nAnd make three branches coming out of the trunk of the tree.\n "),
              Image.asset("asset/a/drawing/picture9.jpg"),
              Text(
                  " \nColor in a cloud shape for the leaves right above the tree branches.\n "),
              Image.asset("asset/a/drawing/picture10.jpg"),
              Text(
                  " \nNext color in the branches and trunck of the tree with a shade of brown.\n "),
              Image.asset("asset/a/drawing/picture11.jpg"),
              Text(
                  " \nNow color the tops of the mountians yellow or light green.\n "),
              Image.asset("asset/a/drawing/picture12.jpg"),
              Text(" \nColor in the rest of the moutain with green.\n "),
              Image.asset("asset/a/drawing/picture13.jpg"),
              Text(
                  " \nmake shure not to color over the sun and clouds while you draw the sky with light blue\n "),
              Image.asset("asset/a/drawing/picture14.png"),
              Text(
                  " \nNext draw the outline of the rocks in gray next to the sides of the river.\n "),
              Image.asset("asset/a/drawing/picture15.png"),
              Text(" \nNow color in the rocks in the same shade of gray.\n "),
              Image.asset("asset/a/drawing/picture16.png"),
              Text(
                  " \nNow draw two wavy lines in brown or a blond yellow around the rocks.\n "),
              Image.asset("asset/a/drawing/picture17.png"),
              Text(" \nNext color it in.\n "),
              Image.asset("asset/a/drawing/picture18.png"),
              Text(
                  " \nFinally color in the rest of the ground in green.\n "),
              Image.asset("asset/a/drawing/picture19.png"),
              Text(" \nNow you are done with your picture!\n "),
            ],
          ),
        ));
  }
}
