import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';

/// Styled Widgets for a post,
/// subtitle and paragraphs

Widget buildSubTitle(String text, double width, double height) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      //height: height * 0.05,
      width: width * 0.90,
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: kHeadingTextStyle,
          ),
        ],
      ),
    ),
  );
}

Widget buildParagraph(String text, double width) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
    child: Container(
      width: width * 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: kParagraphTextStyle,
          ),
        ],
      ),
    ),
  );
}

Widget buildImage(String url, String title, double height, String username, double width) {
  return Container(
      height: height * 0.25,
      width: width,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Colors.black, style: BorderStyle.solid, width:1),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                        child: StrokeText(
                fontSize: 25,
                strokeColor: Colors.black,
                strokeWidth: 6,
                text: title,
                textColor: Colors.white,
              ),
            ),
            Flexible(
                        child: StrokeText(
                fontSize: 20,
                strokeColor: Colors.black,
                strokeWidth: 6,
                text: "By: $username",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
          
      
    
  );
}
