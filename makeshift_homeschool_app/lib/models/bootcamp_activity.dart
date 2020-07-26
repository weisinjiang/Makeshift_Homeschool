import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BootCampActivity {
  Map<int, String> fiveResponse;
  String id;
  String image;
  Map<String, String> template;

  BootCampActivity({this.id}) {
    this.image = "";
    this.fiveResponse = {};
    this.template = {"intro": "", "body": "", "conclusion": "", "signed": ""};
  }

  set setData(DocumentSnapshot document) {
    this.template["intro"] = document["intro"];
    this.template["body"] = document["body"];
    this.template["conclusion"] = document["conclusion"];
    this.image = document["image"];
  }

  /// Gets the total number of inputs needed for single fields
  /// Fields are intro, body, conclusion, signed
  /// Lenght is the split list -1 because if there is 1 user input,
  /// then then the list will be split into 2 halves because the userinput
  /// is in-between.
  /// ie: "hello <userinput> world" = len(["hello", "world"]) = 2

  int getNumberOfInputs(String field) {
    return this.template[field].split("<userinput>").length - 1;
  }

  // /// Given the number of user inputs needed, make a list of text controllers of
  // /// the same size and fill it with TextEditingControllers

  // List<TextEditingController> getTextControllerListMatchingUserinputLenght() {
  //   int size = getNumberOfInputs();
  //   List<TextEditingController> controllers = List(size);
  //   controllers.fillRange(0, size, TextEditingController());
  //   return controllers;
  // }

  /// Split the string in the intro, body or conclusion fields and return the
  /// list after removing <userinput>
  List<String> getSplitListAfterRemovingUserinputBrackets(String field) {
    try {
      return this.template[field].split("<userinput>");
    } catch (error) {
      print(error);
    }
  }

  /// Matches the string in said field: intro, body, conclusion, etc
  /// with the userinput format <userinput> and put these matches in a list
  /// Then, replace those matches in the original stirng with <> and split the
  /// string by <>.
  /// Loop through that list and inbetween, add a textfield for users to enter
  /// text
  /// ![There is a better way, use RegEx that matches things outside of <> and loop through the matches]
  /// [ie, match will be like: "hello", "<hi>"] Just loop through and if it contains
  /// a "<" then it is a input field, otherwise, it's a Text
  List<String> contentsAsStringList(String field) {
    var text = this.template[field];
    var matchedCases = getUserinputMatches(text);

    /// For each match, replace it in the original text with <>
    matchedCases.forEach((matchString) {
      text = text.replaceAll(matchString, "<>");
    });

    /// Remove all the userinput fields and splt it by that value
    List<String> onlyText = text.split("<>");
    return onlyText;
  }

  /// Returns the content of field with user input replaced as <>
  String getContentAsStringWithBrackets(String field) {
    var text = this.template[field];
    var matchedCases = getUserinputMatches(text);

    /// For each match, replace it in the original text with <>
    matchedCases.forEach((matchString) {
      text = text.replaceAll(matchString, "<>");
    });

    return text;
  }

  List<String> getUserinputMatches(String str) {
    /// Matches userinput format in Firestore: <questions?>
    var matchUserinputFormatting = RegExp(r"(<[\w+ ]*.?>)");

    /// call the regex and match the cases and add it to the matchedCases list
    /// .group(0) is the first match case, regex can have multiple matches
    List<String> matchedCases = [];
    matchUserinputFormatting.allMatches(str).forEach((match) {
      matchedCases.add(match.group(0));
    });

    return matchedCases;
  }

  Widget buildWidget(String field, Size screenSize) {
    var contents = contentsAsStringList(field);
    var userInputHints = getUserinputMatches(this.template[field]);
    List<Widget> widgetList = [];

    for (var i = 0; i < contents.length; i++) {
      var text = contents[i];

      if (i == contents.length - 1) {
        // Last item is empty, means last widget is a textform field
        if (contents[i].length == 0) {
          var hint = userInputHints[i];
          hint = hint.replaceAll("<", "");
          hint = hint.replaceAll(">", "");
          widgetList.add(Container(
            width: screenSize.width * 0.30,
            child: TextField(
              maxLines: null,
              decoration: InputDecoration(hintText: hint, labelText: hint),
            ),
          ));
        } else {
          /// if not empty, widget ends with a Text widget
          widgetList.add(Text(
            text,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ));
        }
      } else {
        var hint = userInputHints[i];
        hint = hint.replaceAll("<", "");
        hint = hint.replaceAll(">", "");
        widgetList.add(Text(
          text,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ));
        widgetList.add(Container(
          width: screenSize.width * 0.30,
          child: TextField(
            decoration: InputDecoration(hintText: hint),
            maxLines: null,
          ),
        ));
      }
    }

    return Container(
      width: screenSize.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: widgetList,
      ),
    );
  }
}
