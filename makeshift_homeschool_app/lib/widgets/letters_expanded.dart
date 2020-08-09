import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_lesson.dart';
import 'package:makeshift_homeschool_app/models/letter.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class LetterExpanded extends StatelessWidget {
  final BootCampLesson lesson;

  const LetterExpanded({Key key, this.lesson}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.getId),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGreenSecondary, kGreenSecondary_analogous1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
        child: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
             
              height: screenSize.height * 0.80,
              width: screenSize.width * 0.95,
              child: Text(lesson.getContent.trim(), textAlign: TextAlign.start, style: kParagraphTextStyle,)),
          )
        ]),
      ),
    );
  }
}
