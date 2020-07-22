import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

/// Styled Widgets for a post,
/// subtitle and paragraphs

Widget buildSubTitle(String text, double width, double height) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      height: height * 0.05,
      width: width * 0.90,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          text,
          style: kTitleTextStyle,
        ),
      ),
    ),
  );
}

Widget buildParagraph(String text, double width) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
    child: Container(
      width: width * 0.90,
      child: Column(
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

Widget buildImage(String url, double height, double width) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height * 0.25,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: Colors.black, style: BorderStyle.solid, width:3),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill)),
          
      
    ),
  );
}
