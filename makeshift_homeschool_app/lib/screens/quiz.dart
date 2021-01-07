import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/services/quiz_provider.dart';
import 'package:makeshift_homeschool_app/services/rating_feedback_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  final Post postData;
  final Quiz quiz;

  const QuizScreen({Key key, this.quiz, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);
    final feed = Provider.of<PostFeedProvider>(context);
    return ChangeNotifierProvider<QuizProvider>(
      create: (context) => QuizProvider(quiz: quiz),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text(postData.getTitle, style: simpleTextStyle(),),
        ),
        body: Container(
            height: screenSize.height,
            width: screenSize.width,
            alignment: Alignment.topCenter,
            child: Consumer<QuizProvider>(
              builder: (context, quizProvider, _) {
                // Everything needs to be scrollable to prevent overflow
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // tracks progress on quiz questions
                      Container(
                        child: LinearProgressIndicator(
                          value: quizProvider.getProgress,
                          minHeight: 30,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kGreenPrimary),
                        ),
                      ),

                      // Quiz Question and Options
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Show questions and options if the progress isnt 1
                            if (quizProvider.getProgress != 1) ...[
                              SizedBox(
                                height: 100.0,
                              ),
                              quizProvider.showQuestion(),
                              SizedBox(
                                height: 200,
                              ),
                              Container(
                                  width: screenSize.width * 0.80,
                                  child: quizProvider.showOptions(
                                      context, QuizMode.correctAndIncorrect)),

                              // If quiz scroe is not 3/3, then show how much they got
                              // and ask them to start again
                            ] else if (quizProvider.getScore < 3) ...[
                              SizedBox(
                                height: screenSize.height * 0.10,
                              ),
                              Center(
                                child: Text(
                                  "You scored: ${quizProvider.getScore.toString()}/3",
                                  style: mediumTextStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text(
                                  "You need to get all 3 questions correct to continue.",
                                  style: simpleTextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),

                              // Resets the quiz contents to retake it
                              Container(
                                width: screenSize.width * 0.80,
                                child: RaisedButton(
                                    child: Text("Try the quiz again"),
                                    color: kGreenSecondary,
                                    onPressed: () {
                                      quizProvider.tryAgain();
                                    }),
                              ),

                              // Pop the Quiz screen and go back to the post
                              Container(
                                width: screenSize.width * 0.80,
                                child: RaisedButton(
                                    child: Text("Let me read the lesson again"),
                                    color: kGreenSecondary,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ),
                              // user scored 3/3, now needs to provide rating
                              // and feed back
                            ] else ...[
                              Container(
                                height: screenSize.height * 0.15,
                                width: screenSize.width,
                                //color: Colors.red,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "asset/gif/quizComplete.gif",
                                        ),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: StrokeText(
                                    fontSize: 30,
                                    text:
                                        "🎉 Hurray! You got ${quizProvider.getScore.toString()}/3! 🎉",
                                    strokeColor: Colors.white,
                                    textColor: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),

                              // Ratings Provider
                              ChangeNotifierProvider<Rating_FeedbackProvider>(
                                create: (_) =>
                                    Rating_FeedbackProvider(postData: postData),
                                child: Consumer<Rating_FeedbackProvider>(
                                  builder: (context, ratingFeedback, _) =>
                                      Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      child: ratingFeedback.buildRatingBar(
                                        context,
                                        screenSize,
                                        auth,
                                        feed
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
