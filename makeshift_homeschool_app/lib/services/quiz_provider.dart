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
  int _currentQuestionIndex;
  Question currentQuestion;

  // List of quiz must be passed when initialized
  QuizProvider({this.quiz}) {
    this._progress = 0.0;
    this._currentQuestionIndex = 0;
    this.currentQuestion = quiz.getQuestionAt(0);
  }

  Question get getCurrentQuestion => this.currentQuestion;
  int get getCurrentQuestionIndex => this._currentQuestionIndex;
  double get getProgress => this._progress;

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

  Widget showQuestion() {
    Question currentQuestion = getCurrentQuestion;
    return Text(
      currentQuestion.getQuestion,
      style: kBoldParagraphTextStyle,
    );
  }

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
                  correct ? "That's correct!" : "Oops, not quite right",
                  style: kBoldTextStyle,
                ),
                FlatButton(
                  onPressed: () {
                    if (correct) {
                      nextQuestion();
                    }
                    Navigator.pop(context);
                  },
                  color: correct ? Colors.green : Colors.red,
                  child: Text(
                    correct ? "Next Question!" : "Try again",
                    style: kBoldTextStyle,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
