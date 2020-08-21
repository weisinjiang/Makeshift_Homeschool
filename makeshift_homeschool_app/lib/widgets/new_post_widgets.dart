import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

Widget questionField({TextEditingController controller, final String hint}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      maxLength: 40,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.solidQuestionCircle),
          labelText: hint,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      validator: (userInput) {
        if (!userInput.endsWith("?")) {
          return "Missing question mark.";
        }
        return null;
      },
    ),
  );
}

Widget answerField({TextEditingController controller, bool isCorrect}) {
  // Intro Correct Answer
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: isCorrect ? Icon(FontAwesomeIcons.solidCheckCircle) : Icon(FontAwesomeIcons.solidTimesCircle),
        labelText: isCorrect ? "Correct Answer" : "Wrong Answer",
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
              border: Border.all(color: Colors.black, width: 2.0)
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Make a quiz question for the $part", style: kBoldParagraphTextStyle,),
          questionField(controller: controllers[0], hint: "Question about the $part"),
          answerField(controller: controllers[1], isCorrect: true),
          Text("Trick your readers by putting 3 wrong answers "),
          answerField(controller: controllers[2], isCorrect: false),
          answerField(controller: controllers[3], isCorrect: false),
          answerField(controller: controllers[4], isCorrect: false),
        ],
      ),
    ),
  );
}
