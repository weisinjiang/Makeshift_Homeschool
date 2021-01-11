import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
  Builds 3 questions field for a new post
  1 question each for a posts intro, body and conclusion field
*/

class NewPostQuestions extends StatefulWidget {
  @override
  _NewPostQuestionsState createState() => _NewPostQuestionsState();
}

class _NewPostQuestionsState extends State<NewPostQuestions> {
  @override
  Widget build(BuildContext context) {
 

    final _formKey = GlobalKey<FormState>();

    Map<String, TextEditingController> _controllers = {
      "introQuestion": TextEditingController(),
      "introCorrect": TextEditingController()
    };

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Make a quiz for your readers to take below!"),

          // Intro Question
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
            child: TextFormField(
              controller: _controllers["introQuestion"],
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.questionCircle),
                  labelText: "Question about the Introduction",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
              // user press done after putting in a question, it saves the text
              // into the map file
              onEditingComplete: () {
                var questionText = _controllers["introQuestion"].text;
               
              },
            ),
          ),

          // Intro Correct Answer
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
            child: TextFormField(
              controller: _controllers["introCorrect"],
              decoration: const InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.checkCircle),
                labelText: "Correct Answer",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.vertical()),
              ),
              // When user's press "Done" on keyboard
              onEditingComplete: () {},
            ),
          ),

          Text("Put 3 wrong answers for this question"),

          // Intro Wrong Answer 1
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.timesCircle),
                labelText: "Wrong Answer 1",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.vertical()),
              ),
              // When user's press "Done" on keyboard
              onEditingComplete: () {},
            ),
          ),

          // Intro Wrong Answer 2
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.timesCircle),
                labelText: "Wrong Answer 2",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.vertical()),
              ),
              // When user's press "Done" on keyboard
              onEditingComplete: () {},
            ),
          ),

          // Intro Wrong Answer 3
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 20, 20),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.timesCircle),
                hintText: "Wrong Answer 3",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.vertical()),
              ),
              // When user's press "Done" on keyboard
              onEditingComplete: () {},
            ),
          ),
        ],
      ),
    );
  }
}
