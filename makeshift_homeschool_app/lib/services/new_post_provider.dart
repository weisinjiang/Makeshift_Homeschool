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

  ///Setter code for image
  set setNewPostImageFile(File imageFile) => this._newPostImagePath = imageFile;

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

  // Future<void> post(String uid) async {
  //   var formData = convertToMap(getFormControllers);
  //   _database.collection("lesson").add(data)
  // }
}
