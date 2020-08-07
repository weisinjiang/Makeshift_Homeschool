import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

// At the top of the new post form. Title of the lesson
Widget lessonTitle(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: TextFormField(
      controller: controller,
      style: kHeadingTextStyle,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      maxLines: null,
      maxLength: 18,
      decoration: InputDecoration(
        hintText: "What is your lesson's name?",
        //normal black underline and then when pressed, turns red
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      validator: null,
      onSaved: null,
    ),
  );
}

// At the top of the new post form. Title of the lesson
Widget subTitle(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextFormField(
      controller: controller,
      style: kTitleTextStyle,
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Add a Subtitle",
        //normal black underline and then when pressed, turns red
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      validator: null,
      onSaved: null,
    ),
  );
}

Widget paragraph(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      style: kParagraphTextStyle,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: "Add a Paragraph",
        hoverColor: Colors.black,
        //Outline the border at start as black and turns red when pressed
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      validator: null,
      onSaved: null,
    ),
  );
}


