import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/services/quiz_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  final String postId;
  final Quiz quiz;

  const QuizScreen({Key key, this.postId, this.quiz}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider<QuizProvider>(
      create: (context) => QuizProvider(quiz: quiz),
      child: Scaffold(
        appBar: AppBar(
          title: Text(postId),
        ),
        body: Container(
            height: screenSize.height,
            width: screenSize.width,
            alignment: Alignment.center,
            child: Consumer<QuizProvider>(
              builder: (context, quizProvider, _) {
                return Column(
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
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
              
                          quizProvider.showQuestion(),
                          SizedBox(
                            height: 200,
                          ),
                          Container(
                              width: screenSize.width * 0.80,
                              child: quizProvider.showOptions(context)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
