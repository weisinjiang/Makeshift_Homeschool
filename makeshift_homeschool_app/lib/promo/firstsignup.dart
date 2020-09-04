import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';

/// *************///
/// Intro Slides ///
/// *************///

class IntroSlides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide1.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide2.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide3.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide4.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide5.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide6.png")),
            color: Colors.white,
          ),
          Container(
            child: Center(
                child: Image.asset("asset/intro_slides/introslide7.png")),
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              Center(child: Image.asset("asset/intro_slides/introslide8.png")),
              RaisedButton(
                  child: Text("Next"),
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RootScreen()));
                  })
            ]),
          )
        ],
        pageSnapping: true,
      ),
    );
  }
}
