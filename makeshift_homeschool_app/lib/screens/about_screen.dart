import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeigh = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Makeshift Homeschool",
              style: titleTextStyle(),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "What is Makeshift Homeschool?",
              style: subtitleTextStyle(),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
                "Our goal is to teach kids to love learning. We do this by implementing a Creative Learning Process.", style: TextStyle(color: Colors.lightBlue, fontSize: 15, fontWeight: FontWeight.bold),),
            
            SizedBox(height: 20,),
            Text(
                "We Offer:", style: mediumTextStyle()),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 55,
                    maxRadius: 55,
                    backgroundImage: AssetImage("images/image1.png"),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    color: Colors.greenAccent,
                    child: Text("Virtual Leadership\nTraining", style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    color: Colors.lightBlueAccent,
                    child: Text("Tailored to Each\nChild's Strengths", style: TextStyle(fontSize: 20),),
                  ),
                  Spacer(),
                  CircleAvatar(
                    minRadius: 55,
                    maxRadius: 55,
                    backgroundImage: AssetImage("images/image2.png"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 55,
                    maxRadius: 55,
                    backgroundImage: AssetImage("images/image3.png"),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    color: Colors.green[300],
                    child: Text("Flexable Schedule\nSet By You", style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
