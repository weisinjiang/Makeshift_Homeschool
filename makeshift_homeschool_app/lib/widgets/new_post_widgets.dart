import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';

Widget recommendedAge(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      // only digits
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      maxLength: 2,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Recommended Reader Age",
        hintStyle: TextStyle(color: Colors.white),
        hoverColor: Colors.black,
        suffix: Text("+"),
        //Outline the border at start as black and turns red when pressed
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
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
      style: mediumTextStyle(),
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      maxLines: null,
      maxLength: 30,
      decoration: InputDecoration(
        hintText: "What is your lesson's name?",
        hintStyle: TextStyle(color: Colors.white),
        //normal black underline and then when pressed, turns red
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
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
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Add a Subtitle",
        hintStyle: TextStyle(color: Colors.white),
        //normal black underline and then when pressed, turns red
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
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
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        hoverColor: Colors.black,
        //Outline the border at start as black and turns red when pressed
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
      ),
      validator: null,
      onSaved: (newString) => controller.text = newString ,
    
    ),
  );
}

Widget questionField({TextEditingController controller, final String hint}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      style: simpleTextStyle(),
      controller: controller,
      maxLength: 40,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.solidQuestionCircle,
            color: Colors.white,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent))),
    ),
  );
}

Widget answerField({TextEditingController controller, bool isCorrect}) {
  // Intro Correct Answer
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      style: simpleTextStyle(),
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: isCorrect
            ? Icon(
                FontAwesomeIcons.solidCheckCircle,
                color: Colors.green,
              )
            : Icon(FontAwesomeIcons.solidTimesCircle, color: Colors.red),
        hintText: isCorrect ? "Correct Answer" : "Wrong Answer",
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
        border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
      ),
      // When user's press "Done" on keyboard
    ),
  );
}

/*
  Builds a fill question set
  @param whichPart is which part of the post: intro, body, conclusion
  @controllers is the list of 5 controllers for the quiz question/answers
*/

Widget quizQuestionField(
    {List<TextEditingController> controllers, String part}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 2.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Make a quiz question for the $part",
              style: mediumTextStyle(),
            ),
            questionField(
                controller: controllers[0], hint: "Question about the $part"),
            answerField(controller: controllers[1], isCorrect: true),
            Text("Trick your readers by putting 3 wrong answers ", style: simpleTextStyle(),),
            answerField(controller: controllers[2], isCorrect: false),
            answerField(controller: controllers[3], isCorrect: false),
            answerField(controller: controllers[4], isCorrect: false),
          ],
        ),
      ),
    ),
  );
}
