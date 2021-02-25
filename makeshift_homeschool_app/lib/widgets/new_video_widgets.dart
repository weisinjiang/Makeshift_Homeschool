import 'package:flutter/material.dart';

Widget videoTitle(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: TextFormField(
      controller: controller,
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      maxLines: null,
      maxLength: 30,
      decoration: textFieldInput("Title"),
      validator: null,
      onSaved: null,
    ),
  );
}

Widget description(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: textFieldInput("Description"),
      validator: null,
      onSaved: (newString) => controller.text = newString ,
    ),
  );
}

Widget videoURL(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: TextFormField(
      controller: controller,
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      maxLines: null,
      decoration: textFieldInput("Video URL"),
      validator: null,
      onSaved: null,
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black);
}

InputDecoration textFieldInput(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white60),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)));
}