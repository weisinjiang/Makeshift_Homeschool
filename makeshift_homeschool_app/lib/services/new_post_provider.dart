import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/new_post_widgets.dart';

///Handles new paragraph and subtitle widgets being added to a new post
///and saving its contents
///
///

class NewPostProvider with ChangeNotifier {
  /// One list for widgets and one for text controllers
  /// Did not use map because a text controller needs to be passed into the key
  List<Widget> _newPostForms;
  List<TextEditingController> _newPostFormControllers;
  int currentListSize; // used to add and delete textforms

  /// Initialize it
  void initialize() {
    this._newPostForms = [
      lessonTitle(_newPostFormControllers[0]),
      subTitle(_newPostFormControllers[1]),
      paragraph(_newPostFormControllers[2])
    ];

    this._newPostFormControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    this.currentListSize = 3;
  }

  /// Getters for the variables
  int get getCurrentListSize => this.currentListSize;
  List<Widget> get getNewPostWidgetList => this._newPostForms;
  List<TextEditingController> get getFormControllers =>
      this._newPostFormControllers;

  void incrementCurrentListSize() => this.currentListSize++;
  void decrementCurrentListSize() => this.currentListSize--;

  /// Add a new paragraph field to the form by first adding a controller and
  /// ref that controller in the widget list
  void addParagraph() {
    int controllerIndex = getCurrentListSize - 1; // Index counts from 0
    this._newPostFormControllers.add(TextEditingController());
    this._newPostForms.add(paragraph(_newPostFormControllers[controllerIndex]));
    incrementCurrentListSize(); // increase size
    notifyListeners();
  }

  /// Add a new subtitle field to the form by first adding a controller and
  /// ref that controller in the widget list
  void addSubtitle() {
    int controllerIndex = getCurrentListSize - 1; // Index counts from 0
    this._newPostFormControllers.add(TextEditingController());
    this._newPostForms.add(paragraph(_newPostFormControllers[controllerIndex]));
    incrementCurrentListSize(); // increase size
    notifyListeners();
  }

  /// Removes the last added form
  void removeLastTextForm() {
    this._newPostForms.removeLast();
    this._newPostFormControllers.removeLast();
    decrementCurrentListSize();
    notifyListeners();  
  }
}
