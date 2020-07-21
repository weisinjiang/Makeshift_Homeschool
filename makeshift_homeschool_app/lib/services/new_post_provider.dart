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
  int currentWidgetListSize; // used to add and delete textforms
  File _newPostImagePath;

  /// Initialize it
  NewPostProvider() {
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

  /// Getters for the variables
  int get getcurrentWidgetListSize => this.currentWidgetListSize;
  List<Widget> get getNewPostWidgetList => this._newPostForms;
  List<TextEditingController> get getFormControllers =>
      this._newPostFormControllers;

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
    this._newPostForms.add(paragraph(_newPostFormControllers[controllerIndex]));
    incrementcurrentWidgetListSize(); // increase size
    notifyListeners();
  }

  /// Add a new subtitle field to the form by first adding a controller and
  /// ref that controller in the widget list
  void addSubtitle() {
    int controllerIndex = getcurrentWidgetListSize - 1; // Index counts from 0
    this._newPostFormControllers.add(TextEditingController());
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
      decrementcurrentWidgetListSize();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Convert the list items into a map
  Map<String, String> convertToMap(
      List<TextEditingController> textControllersList) {
    Map<String, String> formData = {};

    for (var i = 0; i < textControllersList.length; i++) {
      formData[i.toString()] = textControllersList[i].text;
    }
    return formData;
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

  /// Takes in the users uid, name and the number of lessons created
  /// Uploads the new post into Firestore using the names
  Future<void> post(String uid, String name, int lessonCreated) async {
    lessonCreated++; // increment # of lessons user created, cant do it when adding to database

    /// Reference the document where the data will be placed
    /// Leaving document empty generates a random id
    var databaseRef = _database.collection("lessons").document();
    var postContentsArray = getControllerTextDataAsList(getFormControllers);
    var imageUrl = await uploadImageAndGetDownloadUrl(
        getNewPostImageFile, databaseRef.documentID);

    var newLesson = {
      "ownerUid": uid,
      "ownerName": name,
      "createdOn": DateTime.now().toString(),
      "likes": 0,
      "imageUrl": imageUrl,
      "postContents": postContentsArray
    };

    /// Add the data into the refernece document made earlier
    await databaseRef.setData(newLesson);

    await _database
        .collection("users")
        .document(uid)
        .setData({"lesson_created": lessonCreated++}, merge: true);
    resetFields(); //!
    print("All Done"); //!
  }

  void resetFields() {
    this._newPostFormControllers.forEach((controller) {
      controller.dispose();
    });


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
