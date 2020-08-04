import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/image_field.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';

///Handles new paragraph and subtitle widgets being added to a new post
///and saving its contents
/// Use a list for the widgets and another list for textcontrollers
///Cant use Form() because each new widget has its own onSave function, which
///cant be dynamically programmed for it to save to a specific variable.

class NewPostProvider with ChangeNotifier {
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
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    // parallel to the above so when adding the post to db, it will be easy to
    // determine if the text was for a subtile, etc
    // O(n) time because when looping through controllers, this can be access by
    // calling the index
    this._newPostFormControllerType = ["title", "subtitle", "paragraph"];

    this._newPostForms = [
      lessonTitle(_newPostFormControllers[0]),
      ImageField(
        imageHeight: 0.50,
        imageWidth: 0.60,
      ),
      subTitle(_newPostFormControllers[1]),
      paragraph(_newPostFormControllers[2])
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

  void incrementcurrentWidgetListSize() => this.currentWidgetListSize++;
  void decrementcurrentWidgetListSize() => this.currentWidgetListSize--;

  ///Setter and getter code for image
  set setNewPostImageFile(File imageFile) => this._newPostImagePath = imageFile;
  File get getNewPostImageFile => this._newPostImagePath;

//!!!!!!!!!
  void debugPrint() {
    print(this._newPostImagePath);
  }

  /// Add a new paragraph field to the form by first adding a controller and
  /// ref that controller in the widget list
  void addParagraph() {
    int controllerIndex = getcurrentWidgetListSize - 1; // Index counts from 0
    this._newPostFormControllers.add(TextEditingController());
    this._newPostFormControllerType.add("paragraph");
    this._newPostForms.add(paragraph(_newPostFormControllers[controllerIndex]));
    incrementcurrentWidgetListSize(); // increase size

    notifyListeners();
  }

  /// Add a new subtitle field to the form by first adding a controller and
  /// ref that controller in the widget list
  void addSubtitle() {
    int controllerIndex = getcurrentWidgetListSize - 1; // Index counts from 0
    this._newPostFormControllers.add(TextEditingController());
    this._newPostFormControllerType.add("subtitle");
    this._newPostForms.add(subTitle(_newPostFormControllers[controllerIndex]));
    incrementcurrentWidgetListSize(); // increase size
    notifyListeners();
  }

  /// Removes the last added form
  /// If the current widget list size is greater than 4, then remove the last
  /// added widget.
  /// If 4, dont remove because the initial post has 4 widgets:
  ///   Title, Image, Subtile, Paragrah
  bool removeLastTextForm() {
    if (getcurrentWidgetListSize > 4) {
      this._newPostForms.removeLast();
      this._newPostFormControllers.removeLast();
      this._newPostFormControllerType.removeLast();
      decrementcurrentWidgetListSize();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Go though the TextEditingController and get the text data on it
  List<String> getControllerTextDataAsList(
      List<TextEditingController> textControllersList) {
    List<String> controllerTextData = []; // text data to return

    textControllersList.forEach((controller) {
      // go through each
      controllerTextData.add(controller.text);
    });

    return controllerTextData;
  }

  ///
  /// It will take the parallel text controller list and the string list that
  /// describes what the controller contains ["title", "subtitle", paragraph]
  ///
  /// Loop through the controllers list using indexes and also use the same index
  /// for the type list to get the type [title, subtitle, paragraph] of the controller
  ///
  /// If the type is a title, map {"title" : text}
  /// If the type is a subtitle, increase the body count because 1 subtitle is
  /// 1 body that contains the subtitle and many paragraphs, mapped as:
  ///         {"body1" : {"subtitle": text} }
  /// If the next text type is a paragraph and not a subtitle, then the map inside
  /// of the body gets an paragraph1 field, where the number after paragraoph is
  /// the paragraph count of that subtitle:
  ///         {"body1" : {"subtitle": text, paragraph1: text} }
  Map<String, dynamic> mapControllerTypeWithText() {
    var controllerText = getNewPostFormControllers;
    var controllerTextType = getNewPostFormControllerType;
    int bodyCount = 0;
    int paragraphCount = 0;
    Map<String, dynamic> typeTextPairMap = {};

    for (var i = 0; i < controllerText.length; i++) {
      var text = controllerText[i].text;
      var type = controllerTextType[i];

      if (type == "title") {
        typeTextPairMap[type] = text;
      } else if (type == "subtitle") {
        ///create a inner map
        ///Every subtitle is another body
        bodyCount++;
        paragraphCount = 0; // start of a paragraph
        typeTextPairMap["body" + bodyCount.toString()] = {"subtitle": text};
      }

      /// body
      else {
        paragraphCount++;
        typeTextPairMap["body" + bodyCount.toString()]
            ["paragraph" + paragraphCount.toString()] = text;
      }
    }
    print(typeTextPairMap);
    return typeTextPairMap;
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

  /// Method checks that each field is filled in
  bool canPost() {
    var canPost = true;
    if (this._newPostImagePath == null) {
      canPost = false;
    }
    this._newPostFormControllers.forEach((controller) {
      if (controller.text.isEmpty) {
        /// if controller is empty, cant post
        canPost = false;
      }
    });
    return canPost; // if no controller is empty, can post
  }

  // Post Method to be added into the database

  Future<void> post(String uid, String name, int lessonCreated) async {
    lessonCreated++; // increment # of lessons user created, cant do it when adding to database

    /// Reference the document where the data will be placed
    /// Leaving document empty generates a random id
    var databaseRef = _database.collection("lessons").document();
    var postContentsMap = mapControllerTypeWithText();
    var newPostTitle = postContentsMap["title"];
    postContentsMap.remove(
        "title"); // remove the title, no var because it returns the value
    var imageUrl = await uploadImageAndGetDownloadUrl(
        getNewPostImageFile, databaseRef.documentID);

    var newLesson = {
      "ownerUid": uid,
      "ownerName": name,
      "createdOn": DateTime.now().toString(),
      "likes": 0,
      "imageUrl": imageUrl,
      "title": newPostTitle,
      "postContents": postContentsMap
    };

    /// Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson);

    await _database
        .collection("users")
        .document(uid)
        .setData({"lesson_created": lessonCreated}, merge: true);

    resetFields();
  }

  void resetFields() {
    /// Dispose the old widget
    this._newPostFormControllers.forEach((controller) {
      controller.dispose();
    });
    this._newPostImagePath = null;

    ///Set up new ones
    this._newPostFormControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    this._newPostForms = [
      lessonTitle(_newPostFormControllers[0]),
      ImageField(
        imageHeight: 0.50,
        imageWidth: 0.90,
      ),
      subTitle(_newPostFormControllers[1]),
      paragraph(_newPostFormControllers[2])
    ];

    this.currentWidgetListSize = _newPostForms.length;
  }
}
