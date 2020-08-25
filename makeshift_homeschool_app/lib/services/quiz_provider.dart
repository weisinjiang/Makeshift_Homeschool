import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

/*
  Quiz Provider that tracks the users quiz progress when they attempt to 
  complete a lesson.

  @param quiz - Quiz object that contains all the questions and options
  @param _progress - the current progress until quiz completion
*/
class QuizProvider with ChangeNotifier {
  Quiz quiz;
  double _progress;
  int _score;
  int _currentQuestionIndex;
  Question currentQuestion;
  List<Widget> _reviewWidgets;

  // List of quiz must be passed when initialized
  QuizProvider({this.quiz}) {
    this._progress = 0.0;
    this._currentQuestionIndex = 0;
    this.currentQuestion = quiz.getQuestionAt(0);
    this._score = 0;
  }

  // Getters
  Question get getCurrentQuestion => this.currentQuestion;
  int get getCurrentQuestionIndex => this._currentQuestionIndex;
  double get getProgress => this._progress;
  int get getScore => this._score;

  // Score + 1 if users get answers correct
  void scoreUp() => this._score++;

  // reset the question and score for user to try again
  // shuffle the question list so they dont appear in the same order
  void tryAgain() {
    this._progress = 0.0;
    this._score = 0;
    this._currentQuestionIndex = 0;
    this.quiz.shuffleQuestionList();
    this.currentQuestion = quiz.getQuestionAt(0);
    notifyListeners();
  }

  // move the question index by 1
  void nextQuestion() {
    // Questions 1-3 has indexes 0, 1, 2
    if (this._currentQuestionIndex < 2) {
      this._currentQuestionIndex++;
      this._progress = this._currentQuestionIndex / 3;
      this.currentQuestion = quiz.getQuestionAt(this._currentQuestionIndex);
    } else {
      // at 2, do not progress to next question, only update progress
      this._progress = 1.0;
      this._currentQuestionIndex++;
    }
    notifyListeners();
  }

  // Shows only when users get a 3/3 in the quiz section.
  // This widget is used to rate the lesson and provide feedback for the owner
  Widget showRatingsAndFeedback() {
    return Column(
      children: [
        
      ],
    );
  }

  // used together with showOptions()
  Widget showQuestion() {
    Question currentQuestion = getCurrentQuestion;
    return Text(
      currentQuestion.getQuestion,
      style: kBoldParagraphTextStyle,
    );
  }

  // multiple choice for question
  Widget showOptions(BuildContext context) {
    List<Option> allOptions = getCurrentQuestion.getAllOptions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: () {
            _bottomSheet(context, allOptions[0].isCorrect);
          },
          child: Text(allOptions[0].getValue),
        ),
        RaisedButton(
          onPressed: () {
            _bottomSheet(context, allOptions[1].isCorrect);
          },
          child: Text(allOptions[1].getValue),
        ),
        RaisedButton(
          onPressed: () {
            print(allOptions[0].isCorrect.toString());
            _bottomSheet(context, allOptions[2].isCorrect);
          },
          child: Text(allOptions[2].getValue),
        ),
        RaisedButton(
          onPressed: () {
            _bottomSheet(context, allOptions[3].isCorrect);
          },
          child: Text(allOptions[3].getValue),
        )
      ],
    );
  }

  // shows a bottom nav when a question is answered
  _bottomSheet(BuildContext context, bool correct) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Are you sure about your answer?",
                  style: kBoldTextStyle,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {
                        nextQuestion();
                        // if the answer was correct, score up
                        if (correct) {
                          scoreUp();
                        }

                        Navigator.pop(context);
                      },
                      color: Colors.green,
                      child: Text(
                        "Yes!",
                        style: kBoldTextStyle,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      child: Text(
                        "No!",
                        style: kBoldTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
