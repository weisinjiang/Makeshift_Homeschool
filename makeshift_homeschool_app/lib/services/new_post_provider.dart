import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/widgets/image_field.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';

///Handles new paragraph and subtitle widgets being added to a new post
///and saving its contents
/// Use a list for the widgets and another list for textcontrollers
///Cant use Form() because each new widget has its own onSave function, which
///cant be dynamically programmed for it to save to a specific variable.

class NewPostProvider {
  /// References to the database and storage so we can upload the new post info
  /// into Firestore and the image to FirebaseStorage
  final Firestore _database = Firestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// One list for widgets and one for text controllers
  /// Did not use map because a text controller needs to be passed into the key
  List<Widget> _newPostForms;
  List<TextEditingController> _newPostFormControllers;
  List<String>
      _newPostFormControllerType; // parallel to _newPostFormController, indicating what info it is
  int currentWidgetListSize; // used to add and delete textforms
  File _newPostImagePath;

  /// Initialize it
  NewPostProvider() {
    this._newPostFormControllers = [
      TextEditingController(), // title
      TextEditingController(), // intro
      TextEditingController(), // body 1
      TextEditingController(), // body 2
      TextEditingController(), // body 3
      TextEditingController(), // conclusion
      TextEditingController(), // age recommendation
    ];

    // parallel to the above so when adding the post to db, it will be easy to
    // determine if the text was for a subtile, etc
    // O(n) time because when looping through controllers, this can be access by
    // calling the index
    this._newPostFormControllerType = ["title", "subtitle", "paragraph"];

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
      recommendedAge(_newPostFormControllers[6])
    ];

    this.currentWidgetListSize = _newPostForms.length;
  }

  /// Getters for the variables
  int get getcurrentWidgetListSize => this.currentWidgetListSize;
  List<Widget> get getNewPostWidgetList => this._newPostForms;
  List<TextEditingController> get getNewPostFormControllers =>
      this._newPostFormControllers;
  List<String> get getNewPostFormControllerType =>
      this._newPostFormControllerType;

  // void incrementcurrentWidgetListSize() => this.currentWidgetListSize++;
  // void decrementcurrentWidgetListSize() => this.currentWidgetListSize--;

  ///Setter and getter code for image
  set setNewPostImageFile(File imageFile) => this._newPostImagePath = imageFile;
  File get getNewPostImageFile => this._newPostImagePath;

//!!!!!!!!!
  void debugPrint() {
    print(this._newPostImagePath);
  }

  /// Go though the TextEditingController and get the text data on it
  List<String> getControllerTextDataAsList() {
    List<String> controllerTextData = []; // text data to return

    this._newPostFormControllers.forEach((controller) {
      // go through each
      controllerTextData.add(controller.text);
    });

    return controllerTextData;
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
    return canPost;
  }

  /* 
    Post Method to be added into the database
    If the userLevel is a tutor, then the post will be added to the review
    database for review before being posted into lesson

    If the userLevel is teacher and above, it gets added to the lessons
    collection and requires no review
  */

  Future<void> post(
      {String uid, String name, int lessonCreated, String userLevel}) async {
    lessonCreated++; // increment # of lessons user created, cant do it when adding to database

    /// Reference the document where the data will be placed
    /// Leaving document empty generates a random id
    var databaseRef = _database.collection("lessons").document();
    var postContentsList = getControllerTextDataAsList();
    var newPostTitle = postContentsList[0]; // index0 = title controller

    var contentsAsMap = {
      "introduction": postContentsList[1],
      "body 1": postContentsList[2],
      "body 2": postContentsList[3],
      "body 3": postContentsList[4],
      "conclusion": postContentsList[5],
    };

    var imageUrl = await uploadImageAndGetDownloadUrl(
        getNewPostImageFile, databaseRef.documentID);

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
      "postContents": contentsAsMap
    };

    /// Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson);

    /// update user's lessons created
    await _database
        .collection("users")
        .document(uid)
        .setData({"lesson_created": lessonCreated}, merge: true);

    resetFields();

    /// reset the form
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
      "postContents": contentsAsMap
    };

    /// Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson, merge: true);
    provider.updateUserPost(
        postId: postData.getPostId,
        postContents: contentsAsMap,
        title: newPostTitle,
        age: postContentsList[6]);
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
    this._newPostFormControllers[0].text = postData.getTitle;
    this._newPostFormControllers[1].text = postData.getIntroduction;
    this._newPostFormControllers[2].text = postData.getBody1;
    this._newPostFormControllers[3].text = postData.getBody2;
    this._newPostFormControllers[4].text = postData.getBody3;
    this._newPostFormControllers[5].text = postData.getConclusion;
    this._newPostFormControllers[6].text = postData.getAge;
  }

  void resetFields() {
    /// Dispose the old widget
    this._newPostFormControllers.forEach((controller) {
      controller.clear();
    });
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

    this.currentWidgetListSize = _newPostForms.length;
  }
}
