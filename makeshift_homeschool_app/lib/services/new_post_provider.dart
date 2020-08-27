import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/widgets/image_field.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';
/*
Handles new paragraph and subtitle widgets being added to a new post
and saving its contents
Use a list for the widgets and another list for textcontrollers
*/

class NewPostProvider {
  /// References to the database and storage so we can upload the new post info
  /// into Firestore and the image to FirebaseStorage
  final Firestore _database = Firestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// One list for widgets and one for text controllers
  List<Widget> _newPostForms;
  List<TextEditingController> _newPostFormControllers;
  // Each post requires 5 question and this list contains a controller for them
  List<TextEditingController> _newPostQuestionsControllers;
  int currentWidgetListSize; // used to add and delete textforms
  File _newPostImagePath;
  Map<String, List<TextEditingController>> _quizControllers;

  /// Initialize it. If postData is given, set the data onto the textfields
  NewPostProvider({Post postData}) {
    this._newPostFormControllers = [
      TextEditingController(), // title
      TextEditingController(), // intro
      TextEditingController(), // body 1
      TextEditingController(), // body 2
      TextEditingController(), // body 3
      TextEditingController(), // conclusion
      TextEditingController(), // age recommendation
    ];

    this._newPostQuestionsControllers = [
      TextEditingController(), // Default question 1
      TextEditingController(), // Default question 2
      TextEditingController(), // Intro question
      TextEditingController(), // Body question
      TextEditingController(), // Conclusion question
    ];
    this._quizControllers = {
      "intro": [
        TextEditingController(), // question
        TextEditingController(), // correct answer
        TextEditingController(), // wrong answers down
        TextEditingController(),
        TextEditingController()
      ],
      "body": [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController()
      ],
      "conclusion": [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController()
      ]
    };

    /// Actual widgets being build on screen
    this._newPostForms = [
      lessonTitle(_newPostFormControllers[0]),
      ImageField(
        imageHeight: 0.70,
        imageWidth: 0.60,
        editImageUrl: "", // if not eidting, this is left empty
      ),
      paragraph(controller: _newPostFormControllers[1], hint: "Introduction"),
      paragraph(controller: _newPostFormControllers[2], hint: "Body 1"),
      paragraph(controller: _newPostFormControllers[3], hint: "Body 2"),
      paragraph(controller: _newPostFormControllers[4], hint: "Body 3"),
      paragraph(controller: _newPostFormControllers[5], hint: "Conclusion"),
      recommendedAge(_newPostFormControllers[6]),
      SizedBox(
        height: 30,
      ),
      quizQuestionField(
          controllers: this._quizControllers["intro"], part: "Introduction"),
      quizQuestionField(
          controllers: this._quizControllers["body"], part: "Body"),
      quizQuestionField(
          controllers: this._quizControllers["conclusion"], part: "Conclusion")
    ];

    if (postData != null) {
      setEditingData(postData);
    }
  }

  /// Getters for the variables
  List<Widget> get getNewPostWidgetList => this._newPostForms;
  List<TextEditingController> get getNewPostFormControllers =>
      this._newPostFormControllers;

  ///Setter and getter code for image
  set setNewPostImageFile(File imageFile) => this._newPostImagePath = imageFile;
  File get getNewPostImageFile => this._newPostImagePath;

  /// Go though the TextEditingController and get the text data on it
  List<String> getControllerTextDataAsList() {
    List<String> controllerTextData = []; // text data to return

    this._newPostFormControllers.forEach((controller) {
      // go through each
      controllerTextData.add(controller.text);
    });

    return controllerTextData;
  }

  /*
    This method constructs the quiz question field for a post
  */

  Map<String, Map<String, dynamic>> constructQuizDataForDatabase() {
    // Reference all the controllers for each field
    var introControllers = this._quizControllers["intro"];
    var bodyControllers = this._quizControllers["body"];
    var conclusionControllers = this._quizControllers["conclusion"];

    Map<String, Map<String, dynamic>> quiz = {
      "intro": {
        "question": introControllers[0].text,
        "correctOption": introControllers[1].text,
        "options": [
          introControllers[1].text,
          introControllers[2].text,
          introControllers[3].text,
          introControllers[4].text
        ]
      },
      "body": {
        "question": bodyControllers[0].text,
        "correctOption": bodyControllers[1].text,
        "options": [
          bodyControllers[1].text,
          bodyControllers[2].text,
          bodyControllers[3].text,
          bodyControllers[4].text
        ]
      },
      "conclusion": {
        "question": conclusionControllers[0].text,
        "correctOption": conclusionControllers[1].text,
        "options": [
          conclusionControllers[1].text,
          conclusionControllers[2].text,
          conclusionControllers[3].text,
          conclusionControllers[4].text
        ]
      },
    };
    return quiz;
  }

  /// Upload the image for the lesson using the lessons uid as its name and return
  /// the download url
  Future<dynamic> uploadImageAndGetDownloadUrl(
      File image, String lessonID) async {
    var storageRef = _storage
        .ref()
        .child("lessons")
        .child(lessonID); // storage to put the file
    await storageRef
        .putFile(image)
        .onComplete; // wait for it to finish uploading the file
    return storageRef.getDownloadURL();

    /// Return the download url
  }

  /// Method checks that each field is filled in.
  /// If there is no image path, then user cannot post, return false.
  /// Then check the controllers for each paragraph and if it is empty return
  /// false
  /// Else, return true
  bool canPost({bool isEdit}) {
    var canPost = true;

    /// image file is emtpy and it is not editing
    /// If it is editing, image cannot be changed so check only controllers
    if (this._newPostImagePath == null && !isEdit) {
      canPost = false;
    }

    this._newPostFormControllers.forEach((controller) {
      if (controller.text.isEmpty) {
        /// if controller is empty, cant post
        canPost = false;
      }
    });
    // Check if the quiz fields are all filled out
    this._quizControllers["intro"].forEach((controller) {
      if (controller.text.isEmpty) {
        canPost = false;
      }
    });
    this._quizControllers["body"].forEach((controller) {
      if (controller.text.isEmpty) {
        canPost = false;
      }
    });
    this._quizControllers["conclusion"].forEach((controller) {
      if (controller.text.isEmpty) {
        canPost = false;
      }
    });

    // // check for matching answers/options
    // for (String part in ["intro", "body", "conclusion"]) {
    //   print(part);
    //   if (matchingOptions(this._quizControllers[part])) {
    //     canPost = false;
    //   }
    // }
    return canPost;
  }

  //! TEST AGIAN
  // Checks if response are matching. Wrong answer cannot match correct answer
  bool matchingOptions(List<TextEditingController> controllers) {
    List<String> options;
    options = controllers.map((controller) {
      // trim white space and convert to lower case
      return controller.text.trim().toLowerCase();
    }).toList();
    int setLength = options
        .toSet()
        .length; // make it into a set so there are no repeating elememts

    // if less than 4, then the options had matching answers.
    print(setLength.toString());
    if (setLength < 5) {
      return true;
    }
    return false;
  }

  /* 
    Post Method to be added into the database
    If the userLevel is a tutor, then the post will be added to the review
    database for review before being posted into lesson

    If the userLevel is teacher and above, it gets added to the lessons
    collection and requires no review

    @collection - "lesson" or "review"
  */

  Future<void> post(
      {String uid, String name, int lessonCreated, String userLevel}) async {
    lessonCreated++; // increment # of lessons user created, cant do it when adding to database
    var databaseRef; // refernece to document the post will go into

    // if user is a Tutor, add it to approval collection
    if (userLevel == "Tutor") {
      databaseRef = _database.collection("approval required").document();
    }
    // teachers and above gets their post added to lessons directly
    else {
      databaseRef = _database.collection("lessons").document();
    }

    // Contruct all the data from the text controllers
    var postContentsList = getControllerTextDataAsList();
    var quiz = constructQuizDataForDatabase();
    var newPostTitle = postContentsList[0]; // index0 = title controller

    // Post contents
    var contentsAsMap = {
      "introduction": postContentsList[1],
      "body 1": postContentsList[2],
      "body 2": postContentsList[3],
      "body 3": postContentsList[4],
      "conclusion": postContentsList[5],
    };

    // upload the image and get the url so it can be referenced
    var imageUrl = await uploadImageAndGetDownloadUrl(
        getNewPostImageFile, databaseRef.documentID);

    // all data needed for a new post
    var newLesson = {
      "age": postContentsList[6],
      "views": 0,
      "lessonId": databaseRef.documentID,
      "ownerUid": uid,
      "ownerName": name,
      "createdOn": DateTime.now().toString(),
      "likes": 0,
      "imageUrl": imageUrl,
      "title": newPostTitle,
      "postContents": contentsAsMap,
      "quiz": quiz,
      "rating": 5.0,
      "raters": 1
    };

    // Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson);

    // update user's lessons created if they are not a tutor
    // Tutors will have this incremented after review
    if (userLevel != "Tutor") {
      lessonCreated++; // increment by 1
      await _database
          .collection("users")
          .document(uid)
          .updateData({"lesson_created": lessonCreated});
    }

    //resetFields();
  }

  /*
    Update the users post on the database and update the local post so that
    another call to the database can be avoided.
  */
  Future<void> update(Post postData, PostFeedProvider provider) async {
    /// Reference the document where the data will be placed
    /// Leaving document empty generates a random id
    var databaseRef =
        _database.collection("lessons").document(postData.getPostId);
    var postContentsList = getControllerTextDataAsList();
    var quiz = constructQuizDataForDatabase(); // updated quiz data
    var newPostTitle = postContentsList[0]; // index0 = title controller

    var contentsAsMap = {
      "introduction": postContentsList[1],
      "body 1": postContentsList[2],
      "body 2": postContentsList[3],
      "body 3": postContentsList[4],
      "conclusion": postContentsList[5],
    };

    var newLesson = {
      "age": postContentsList[6],
      "title": newPostTitle,
      "postContents": contentsAsMap,
      "quiz": quiz
    };

    /// Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson, merge: true);

    // update the post feed with the new data so it does not need to fetch again
    provider.updateUserPost(
        postId: postData.getPostId,
        postContents: contentsAsMap,
        title: newPostTitle,
        age: postContentsList[6],
        newQuiz: quiz);
    resetFields();

    /// reset the form
  }

  /*
    Metod is for when users want to edit their posts
    Set the text controllers with default values
  */
  void setEditingData(Post postData) {
    this._newPostForms[1] = ImageField(
      imageHeight: 0.70,
      imageWidth: 0.60,
      editImageUrl: postData.getImageUrl,
    );
    // Set data of post
    this._newPostFormControllers[0].text = postData.getTitle;
    this._newPostFormControllers[1].text = postData.getIntroduction;
    this._newPostFormControllers[2].text = postData.getBody1;
    this._newPostFormControllers[3].text = postData.getBody2;
    this._newPostFormControllers[4].text = postData.getBody3;
    this._newPostFormControllers[5].text = postData.getConclusion;
    this._newPostFormControllers[6].text = postData.getAge;

    // Set data on Questions
    for (String part in ["intro", "body", "conclusion"]) {
      // data as map with keys being "question," "options," "correctOptons"
      Map<String, dynamic> dataAsMap = postData.getQuizDataAsMapFor(part);
      print(dataAsMap.toString());

      // List of all options. Remove the correct option
      List<dynamic> optionsList = dataAsMap["options"];
      optionsList.remove(dataAsMap["correctOption"]);
      print(optionsList.toString());

      this._quizControllers[part][0].text = dataAsMap["question"];
      this._quizControllers[part][1].text = dataAsMap["correctOption"];
      this._quizControllers[part][2].text = optionsList[0];
      this._quizControllers[part][3].text = optionsList[1];
      this._quizControllers[part][4].text = optionsList[2];
    }
  }

  void resetFields() {
    // Clear text that is on the controllers
    this._newPostFormControllers.forEach((controller) {
      controller.clear();
    });

    // Clear the question;s controllers
    this._newPostQuestionsControllers.forEach((controller) {
      controller.clear();
    });

    // Clear image path
    this._newPostImagePath = null;

    this._newPostForms = [
      lessonTitle(_newPostFormControllers[0]),
      ImageField(
        imageHeight: 0.50,
        imageWidth: 0.60,
      ),
      paragraph(controller: _newPostFormControllers[1], hint: "Introduction"),
      paragraph(controller: _newPostFormControllers[2], hint: "Body 1"),
      paragraph(controller: _newPostFormControllers[3], hint: "Body 2"),
      paragraph(controller: _newPostFormControllers[4], hint: "Body 3"),
      paragraph(controller: _newPostFormControllers[5], hint: "Conclusion"),
      recommendedAge(_newPostFormControllers[6])
    ];
  }
}
