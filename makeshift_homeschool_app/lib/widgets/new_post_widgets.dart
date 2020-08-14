import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';


Widget recommendedAge(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      style: kParagraphTextStyle,
      keyboardType: TextInputType.number,
      // only digits
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      maxLength: 2,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Recommended Reader Age",
        hoverColor: Colors.black,
        suffix: Text("+"),
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
      maxLength: 30,
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

Widget paragraph({TextEditingController controller, final String hint}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      style: kParagraphTextStyle,
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hint,
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
