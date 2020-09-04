import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/promo/promo_questions.dart';
import 'package:makeshift_homeschool_app/services/quiz_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:provider/provider.dart';

/*
  Tutor tutorial when Student gets promoted.
*/
class TutorBootcamp extends StatelessWidget {
  // These are final because every tutor will answer the same question
  final Quiz quiz = getTutorPromoQuiz();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider<QuizProvider>(
      create: (context) => QuizProvider(quiz: quiz),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "Promotion",
        )),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          alignment: Alignment.topCenter,
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: LinearProgressIndicator(
                        value: quizProvider.getProgress,
                        minHeight: 30,
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kGreenPrimary),
                      ),
                    ),

                    // Quiz Contents
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // When the quiz isnt finished yet
                          if (quizProvider.getProgress != 1) ...[
                            SizedBox(
                              height: 100.0,
                            ),
                            //Questions
                            quizProvider.showQuestion(),
                            SizedBox(
                              height: 200,
                            ),
                            // Options
                            Container(
                                width: screenSize.width * 0.80,
                                child: quizProvider.showOptions(
                                    context, QuizMode.correctOnly)),
                          ] else ...[
                            Container(
                              child: StrokeText(
                                fontSize: 30,
                                strokeColor: Colors.black,
                                textColor: Colors.white,
                                text: "Tutorial Complete!",
                                strokeWidth: 3,

                              ),
                            ),
                            SizedBox(height: 100,),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Go back"),
                            )
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
