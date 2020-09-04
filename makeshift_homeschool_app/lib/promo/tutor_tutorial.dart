import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/promo/tutor.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';

/*
  Handles showing the slides when promoted
*/

class TutorTutorialScreen extends StatelessWidget {
  // This variable determines which slide is shown
  final TutorTutorialSlides slide;

  const TutorTutorialScreen({Key key, this.slide}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // size of the screen
    List<Widget> toShow = []; // widgets to be included in PageView

    // Slides 1-3 are slides before the first question
    if (slide == TutorTutorialSlides.intro) {
      for (var i = 1; i < 4; i++) {
        // on the last item, add a button
        if (i == 3) {
          toShow.add(Column(
            children: [
              Image.asset(
                "asset/tutor_slides/tutorslide$i.png",
                alignment: Alignment.topCenter,
              ),
              Container(
                width: screenSize.width * 0.80,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context); // pop the screen
                    Navigator.push(
                        // start the tutor intro tutorial
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TutorBootcamp()));
                  },
                  color: kGreenPrimary,
                  child: Text("Continue"),
                ),
              ),
            ],
          ));
        } else {
          toShow.add(Image.asset(
            "asset/tutor_slides/tutorslide$i.png",
            alignment: Alignment.topCenter,
          ));
        }
      }
      // Body Slides
    } else if (slide == TutorTutorialSlides.body) {
      toShow.add(Column(
        children: [
          Image.asset(
            "asset/tutor_slides/tutorslide4.png",
            alignment: Alignment.topCenter,
          ),
          Container(
            width: screenSize.width * 0.80,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: kGreenPrimary,
              child: Text("Continue"),
            ),
          ),
        ],
      ));
      // Conclusion Slides
    } else if (slide == TutorTutorialSlides.conclusion) {
      toShow.add(Column(
        children: [
          Image.asset(
            "asset/tutor_slides/tutorslide5.png",
            alignment: Alignment.topCenter,
          ),
          Container(
            width: screenSize.width * 0.80,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: kGreenPrimary,
              child: Text("Continue"),
            ),
          ),
        ],
      ));
      // Quiz Slides
    } else if (slide == TutorTutorialSlides.quiz) {
      toShow.add(Column(
        children: [
          Image.asset(
            "asset/tutor_slides/tutorslide6.png",
            alignment: Alignment.topCenter,
          ),
          Container(
            width: screenSize.width * 0.80,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: kGreenPrimary,
              child: Text("Continue"),
            ),
          ),
        ],
      ));
      // Finish Slide
    } else {
      toShow.add(Column(
        children: [
          Image.asset(
            "asset/tutor_slides/tutorslide7.png",
            alignment: Alignment.topCenter,
          ),
          Container(
            width: screenSize.width * 0.80,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context); // pop this screen
              },
              color: kGreenPrimary,
              child: Text("Finish"),
            ),
          ),
        ],
      ));
    }
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: screenSize.height,
        width: screenSize.width,
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: toShow,
          pageSnapping: true,
        ),
      ),
    );
  }
}
