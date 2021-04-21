import 'package:flutter/material.dart';

// TextStyle simpleTextStyle() {
//   return TextStyle(
//     color: Colors.white,
//   );
// }

InputDecoration textFieldInput(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
 return TextStyle(color: Colors.white);
}
 
TextStyle mediumTextStyle() {
 return TextStyle(color: Colors.white, fontSize: 20);
}
 
TextStyle titleTextStyle() {
 return TextStyle(
     color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold);
}
 
TextStyle subtitleTextStyle() {
 return TextStyle(
   color: Colors.grey[300],
   fontSize: 20,
 );
}
 
AppBar mainAppBar() {
 return AppBar(
   backgroundColor: Colors.black,
   title: Text(
     "Makeshift Homeschool",
     style: mediumTextStyle(),
   ),
 );
}
