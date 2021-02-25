import 'package:flutter/material.dart';
import 'dart:core';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/screens/quiz.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/popup_appbar.dart';
import 'package:flutter/foundation.dart';

/// Expanded Post after clicking on a Post Thumbnail.
/// Enlarged so you can see all the details for the post
/// Post has a method called constructPostWidgetListthat makes the widget list
/// to be displayed in ListView
class PostExpanded extends StatelessWidget {
  final PostExpandedViewType viewType;

  /// if in user's profile, they can delete the post
  final postData;
  final bool isVideo;

  /// post data passed from PostThumbnail

  const PostExpanded({Key key, this.postData, this.viewType, this.isVideo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PopupMenuAppBar(
        postData: postData,
        backgroundColor: kPeachRed,
        screenSize: screenSize,
        appBar: AppBar(),
        canDelete: viewType == PostExpandedViewType.owner ? true : false,
        isVideo: isVideo,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        alignment: Alignment.topCenter,
        child: Container(
          width: kIsWeb 
            ? screenSize.width * 0.50
            : screenSize.width,
          height: screenSize.height,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: postData.constructPostWidgetList(screenSize),
                ),

                // if in user profile, then dont show "Complete Lesson"
                // SHow only if it is not a video post
                if (viewType == PostExpandedViewType.global && !isVideo)
                  Container(
                      width: screenSize.width * 0.80,
                      height: screenSize.height * 0.10,
                      child: RaisedButton(
                        color: Colors.green[300],
                        onPressed: postData.isCompleted
                            ? null
                            : () {
                                // Pass the quiz map into the Quiz object
                                Quiz quiz = Quiz(quizData: postData.getQuiz);
                                // serialize the data and make them into Question and
                                // options objects before passing it into the quiz screen
                                quiz.serializeQuizData();
                                Navigator.push(
                                    context,
                                    SlideLeftRoute(
                                        screen: QuizScreen(
                                      postData: postData,
                                      quiz: quiz,
                                    )));
                              },
                        child: Text("Complete Lesson"),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
