import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/promo/tutor_tutorial.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';

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
  int _totalQuestions;
  int _currentQuestionIndex;
  Question currentQuestion;

  // List of quiz must be passed when initialized
  QuizProvider({this.quiz}) {
    this._progress = 0.0;
    this._currentQuestionIndex = 0;
    this._totalQuestions = quiz.getQuestionListSize;
    this.currentQuestion = quiz.getQuestionAt(0);
    this._score = 0;
  }

  // Getters
  Question get getCurrentQuestion => this.currentQuestion;
  int get getCurrentQuestionIndex => this._currentQuestionIndex;
  double get getProgress => this._progress;
  int get getScore => this._score;
  int get numberOfQuestions => this._totalQuestions;

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
    // Question index is less by 1
    if (this._currentQuestionIndex < numberOfQuestions - 1) {
      this._currentQuestionIndex++;
      this._progress = this._currentQuestionIndex / numberOfQuestions;
      this.currentQuestion = quiz.getQuestionAt(this._currentQuestionIndex);
    } else {
      // at 2, do not progress to next question, only update progress
      this._progress = 1.0;
      this._currentQuestionIndex++;
    }
    notifyListeners();
  }

  // used together with showOptions()
  Widget showQuestion() {
    Question currentQuestion = getCurrentQuestion;
    return Text(
      currentQuestion.getQuestion,
      style: mediumTextStyle(),
    );
  }

  // Multiple choice for questions
  // Quizmode will determine if the quiz will continue like a test or let the
  // user retry until it's correct
  Widget showOptions(BuildContext context, QuizMode mode) {
    List<Widget> allOptions;

    if (mode == QuizMode.correctAndIncorrect) {
      allOptions = getCurrentQuestion.getAllOptions
          .map<Widget>((option) => RaisedButton(
                onPressed: () => _bottomSheet(context, option.isCorrect),
                child: Text(option.getValue),
              ))
          .toList();
    } else {
      allOptions = getCurrentQuestion.getAllOptions
          .map<Widget>((option) => RaisedButton(
                onPressed: () =>
                    _bottomSheetCorrectAnsOnly(context, option.isCorrect),
                child: Text(option.getValue),
              ))
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: allOptions,
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
                        "Yes 😃",
                        style: kBoldTextStyle,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      child: Text(
                        "No 🤔",
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

  // shows a bottom nav when a question is answered, but only allows you to
  // continue if it's the correct answer
  _bottomSheetCorrectAnsOnly(BuildContext context, bool correct) {
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
                  correct ? "Correct! 😃" : "Wrong! 💩",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: correct ? Colors.green : Colors.red),
                ),
                FlatButton(
                  onPressed: () {
                    // if correct move onto the next question
                    if (correct) {
                      nextQuestion();
                      scoreUp();
                      Navigator.pop(context);

                      if (getScore == 1) {
                        Navigator.push(
                            // start the tutor intro tutorial
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TutorTutorialScreen(
                                      slide: TutorTutorialSlides.body,
                                    )));
                      } else if (getScore == 2) {
                        Navigator.push(
                            // start the tutor intro tutorial
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TutorTutorialScreen(
                                      slide: TutorTutorialSlides.conclusion,
                                    )));
                      } else if (getScore == 3) {
                        Navigator.push(
                            // start the tutor intro tutorial
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TutorTutorialScreen(
                                      slide: TutorTutorialSlides.quiz,
                                    )));
                      } else if (getScore == 4) {
                        Navigator.push(
                            // start the tutor intro tutorial
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    TutorTutorialScreen(
                                      slide: TutorTutorialSlides.finish,
                                    )));
                      }
                    } else {
                      // otherwise, just pop the screen and try again
                      Navigator.pop(context);
                    }
                  },
                  color: correct ? Colors.greenAccent : Colors.redAccent,
                  child: Text(correct ? "Continue" : "Try Again"),
                ),
              ],
            ),
          );
        });
  }
}
