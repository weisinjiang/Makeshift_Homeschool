import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/quiz_model.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';

/*
  This class handles post reviews from Tutors.

  Principles will be able to approve or deny the lesson based on content
  Teachers are given feedback boxes for users to improve on the content
*/

class PostReviewProvider {
  final Firestore _database = Firestore.instance;
  Post postData;
  Quiz quizData;
  Reviewer reviewer;
  Map<String, TextEditingController> feedback;

  PostReviewProvider({this.postData, this.reviewer}) {
    this.quizData = Quiz(quizData: postData.getQuiz);
    this.quizData.serializeQuizData(); // make data into objects

    // only initialize controllers if it's a teacher
    if (reviewer == Reviewer.teacher) {
      this.feedback = {
        "introduction": TextEditingController(),
        "body 1": TextEditingController(),
        "body 2": TextEditingController(),
        "body 3": TextEditingController(),
        "conclusion": TextEditingController(),
        "question 0": TextEditingController(),
        "question 1": TextEditingController(),
        "question 2": TextEditingController()
      };
    }
  }

  // increment the user's lesson created field and promote if the lastest
  // approved post makes it 5.
  Future<void> incrementUserLessonCreated() async {
    try {
      DocumentReference doc =
          Firestore.instance.collection("users").document(postData.getOwnerUid);
      DocumentSnapshot docData = await doc.get();

      if (docData["lesson_created"] + 1 == 5) {
        doc.updateData({"level": "Teacher", "lesson_created": 5});
      } else {
        doc.updateData({"lesson_created": FieldValue.increment(1)});
      }
    } catch (error) {
      print("Errror with incrementing lesson created $error");
      throw error;
    }
  }

  // Increment the posts "approval" counter by 1. When it reaches 2, move it
  // to the global lessons collection
  // Also increment the user's "Lesson Created by 1"
  Future<void> teacherApprove() async {
    try {
      DocumentReference doc =
          Firestore.instance.collection("review").document(postData.getPostId);
      DocumentSnapshot docData = await doc.get();
      // if this approval makes the approval 2, then add it to lessons
      if (docData["approvals"] + 1 == 2) {
        // Post data, Firestore cant move documents
        Map<String, dynamic> data = {
          "age": postData.getAge,
          "views": 0,
          "lessonId": postData.getPostId,
          "ownerUid": postData.getOwnerUid,
          "ownerName": postData.getOwnerName,
          "createdOn": DateTime.now().toString(),
          "likes": 0,
          "imageUrl": postData.getImageUrl,
          "title": postData.getTitle,
          "postContents": postData.getPostContents,
          "quiz": postData.getQuiz,
          "rating": 5.0,
          "raters": 1,
          "ownerEmail": postData.getOwnerEmail,
        };

        // Write the data into review collection
        await _database
            .collection("lessons")
            .document(postData.getPostId)
            .setData(data);

        // Delete from Review collection
        await _database
            .collection("review")
            .document(postData.getPostId)
            .delete();

        // increment the lesson created by 1 and promote if it becomes 5
        await incrementUserLessonCreated();
      
      // if approve is not 2 yet
      } else {
        doc.updateData({"approvals": FieldValue.increment(1)});
      }
    } catch (error) {
      // !if the post is no longer in th
      print(
          "Teacher Approve post that doesnt exists in Review Collection $error");
      throw error;
    }
  }

  bool canSend() {
    bool canSend = true;
    this.feedback.forEach((key, value) {
      if (value.text.isEmpty) {
        canSend = false;
      }
    });
    return canSend;
  }

  // Add the feedback into a Feedback collection in the document
  Future<void> sendFeedback() async {
    bool isSuccessful = false;
    Map<String, String> feedbacks = {};
    this.feedback.forEach((key, controller) {
      feedbacks[key] = controller.text;
    });
    // add it to the
    try {
      await Firestore.instance
          .collection("review")
          .document(postData.getPostId)
          .collection("feedback")
          .document()
          .setData(feedbacks);
    } catch (error) {
      // !if the post is no longer in th
      print(
          "Teacher sending feedback to a post that doesnt exists in Review Collection$error");
      throw error;
    }
  }

  // When Principle denies the lesson, email is send to the owner informing them
  Future<void> deny(Post postData, String email) async {
    // REST API link
    String url =
        "https://us-east4-makeshift-homeschool-281816.cloudfunctions.net/send_lesson_denied_email";

    // Cloud function takes in a json body
    Map<String, dynamic> jsonData = {
      "data": {
        "username": postData.getOwnerName,
        "email": email,
        "lessonTitle": postData.getTitle
      }
    };

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    // describes the type of data of the http request
    request.headers.set('content-type', 'application/json');
    // encode the json and add it to the http request
    request.add(utf8.encode(json.encode(jsonData)));
    // calls the request and returns a val, then close it
    HttpClientResponse response = await request.close();
    // reponse of the request
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
  }

  // Approve the post and move it into the review collection
  // First read the document from the approval required collection
  // Then delete it and write the copied data into "Review" collection
  Future<void> principleApprove() async {
    try {
      // Post data, Firestore cant move documents
      Map<String, dynamic> data = {
        "age": postData.getAge,
        "views": 0,
        "lessonId": postData.getPostId,
        "ownerUid": postData.getOwnerUid,
        "ownerName": postData.getOwnerName,
        "createdOn": DateTime.now().toString(),
        "likes": 0,
        "imageUrl": postData.getImageUrl,
        "title": postData.getTitle,
        "postContents": postData.getPostContents,
        "quiz": postData.getQuiz,
        "rating": 5.0,
        "raters": 1,
        "ownerEmail": postData.getOwnerEmail,
        "approvals": 0
      };

      // Write the data into review collection
      await _database
          .collection("review")
          .document(postData.getPostId)
          .setData(data);

      // Delete the old data
      await _database
          .collection("approval required")
          .document(postData.getPostId)
          .delete();
    } catch (error) {
      throw error;
    }
  }

  // Getters
  TextEditingController getControllerFor(String type) => this.feedback[type];

  // Feedback Widget for each of the fields
  Widget feedbackForm(TextEditingController controller, String hint) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      maxLength: 400,
      maxLines: null,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            FontAwesomeIcons.solidCommentAlt,
            color: kRedOrange,
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: kPaleBlue))),
    );
  }

  Widget quizQuestionAndOption(Question question, Size screenSize) {
    return Container(
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.getQuestion,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "A.  ${question.getOption1.getValue}",
              style: simpleTextStyle(),
            ),
            Text("B.  ${question.getOption2.getValue}",
                style: simpleTextStyle()),
            Text("C.  ${question.getOption3.getValue}",
                style: simpleTextStyle()),
            Text("D.  ${question.getOption4.getValue}",
                style: simpleTextStyle()),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  // Method builds the widgets needed for the feedback page
  List<Widget> constructPostAndFeedbackBoxes(Size screenSize) {
    List<Widget> contentToShowOnScreen = [];

    /// Map<String, Map<String, String>> from database
    var postContentList = postData.getPostContents;
    contentToShowOnScreen.add(buildImage(postData.getImageUrl,
        postData.getTitle, screenSize.height, postData.getOwnerName, screenSize.width));
    contentToShowOnScreen.add(SizedBox(
      height: 30,
    ));

    /// For each value in the list, build the paragraph
    List<String> postParts = [
      "Introduction",
      "Body 1",
      "Body 2",
      "Body 3",
      "Conclusion"
    ];

    for (var type in postParts) {
      contentToShowOnScreen.add(buildParagraph(
          postContentList[type.toLowerCase()], screenSize.width));

      contentToShowOnScreen.add(SizedBox(
        height: 20,
      ));

      //teachers are given feedback boxes
      if (reviewer == Reviewer.teacher) {
        contentToShowOnScreen.add(feedbackForm(
            getControllerFor(type.toLowerCase()), "$type Feedback Box"));

        contentToShowOnScreen.add(SizedBox(
          height: 50,
        ));
      }
    }
    // Builds the Quiz Section
    contentToShowOnScreen.add(Divider());
    for (var i = 0; i < 3; i++) {
      Question question = this.quizData.getQuestionAt(i);

      contentToShowOnScreen.add(quizQuestionAndOption(question, screenSize));
      // add feedback box if reviewer is a teacher
      if (reviewer == Reviewer.teacher) {
        contentToShowOnScreen.add(feedbackForm(
            getControllerFor("question $i"), "Question $i Feedback Box"));
        contentToShowOnScreen.add(SizedBox(height: 50));
      }
    }

    return contentToShowOnScreen;
  }
}
