import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/letter.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class LetterExpanded extends StatelessWidget {
  final Letter letter;

  const LetterExpanded({Key key, this.letter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(letter.getId),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/paperTexture.jpg'),
                fit: BoxFit.fill)),
        child: ListView(children: <Widget>[
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              letter.getIntro,
              style: kHeadingTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              letter.getBody,
              style: kParagraphTextStyle,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Here are my suggestions:",
              style: kBoldParagraphTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "1. ${letter.getReason("0")}",
                    style: kParagraphTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "2. ${letter.getReason("1")}",
                    style: kParagraphTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "3. ${letter.getReason("2")}",
                    style: kParagraphTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "4. ${letter.getReason("3")}",
                    style: kParagraphTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "5. ${letter.getReason("4")}",
                    style: kParagraphTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              letter.getConclusion,
              style: kParagraphTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ]),
      ),
    );
  }
}
