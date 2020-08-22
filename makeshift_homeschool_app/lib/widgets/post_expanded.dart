import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/screens/quiz.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/popup_appbar.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
/// Post has a method called constructPostWidgetListthat makes the widget list
/// to be displayed in ListView
class PostExpanded extends StatelessWidget {
  final bool canDelete;

  /// if in user's profile, they can delete the post
  final Post postData;

  /// post data passed from PostThumbnail

  const PostExpanded({Key key, this.postData, this.canDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PopupMenuAppBar(
        postData: postData,
        backgroundColor: kPeachRed,
        screenSize: screenSize,
        appBar: AppBar(),
        canDelete: canDelete,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height * 0.85,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: postData.constructPostWidgetList(screenSize),
              ),
              Container(
                  width: screenSize.width * 0.80,
                  child: RaisedButton(
                    color: Colors.green[300],
                    onPressed: () {
                      // Pass the quiz map into the Quiz object
                      Quiz quiz = Quiz(quizData: postData.getQuiz);
                      // serialize the data and make them into Question and
                      // options objects before passing it into the quiz screen
                      quiz.serializeQuizData();
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              screen: QuizScreen(
                            postId: postData.getTitle,
                            quiz: quiz,
                          )));
                    },
                    child: Text("Complete Lesson"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
