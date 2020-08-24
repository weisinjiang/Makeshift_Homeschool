import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';

class Post with ChangeNotifier {
  int _likes;
  int _views;
  String _imageUrl;
  String _age;
  String _createdOn;
  String _ownerName;
  String _ownerUid;
  String _title;
  String _postId;
  bool isLiked;
  // Subtitles and paragraphs in order from Firestore
  Map<String, dynamic> _postContents;
  Map<String, dynamic> _quiz;

  Post() {
    this._views = 0;
    this._likes = 0;
    this._title = null;
    this._imageUrl = null;
    this._createdOn = null;
    this._ownerName = null;
    this._ownerUid = null;
    this._postContents = null;
    this._postId = null;
    this._quiz = null;
    this._age = "0";
    this.isLiked = false;

    /// post is not liked initially
  }

  //Getters
  int get getLikes => this._likes;
  int get getViews => this._views;
  String get getTitle => this._title; // First in array is title
  String get getImageUrl => this._imageUrl;
  String get getCreatedOn => this._createdOn;
  String get getOwnerName => this._ownerName;
  String get getOwnerUid => this._ownerUid;
  String get getPostId => this._postId;
  String get getAge => this._age;

  // Get post content data
  String get getIntroduction => this._postContents["introduction"];
  String get getBody1 => this._postContents["body 1"];
  String get getBody2 => this._postContents["body 2"];
  String get getBody3 => this._postContents["body 3"];
  String get getConclusion => this._postContents["conclusion"];

  // Get post quiz data as Map
  Map<String, dynamic> getQuizDataAsMapFor(String part) {
    Map<String, dynamic> map = {};
    Map<String, dynamic> dataOnPart = this._quiz[part];
    map["question"] = dataOnPart["question"]; // string
    map["correctOption"] = dataOnPart["correctOption"]; // string
    map["options"] = dataOnPart["options"]; //array of length 4
    return map;
  }

  Map<String, dynamic> get getQuiz => this._quiz;
  Map<String, dynamic> get getPostContents => this._postContents;

  //Setters
  set setLikes(int likes) => this._likes = likes;
  set setViews(int views) => this._views = views;
  set setTitle(String title) => this._title = title;
  set setImageUrl(String url) => this._imageUrl = url;
  set setCreatedOn(String time) => this._createdOn = time;
  set setOwnerName(String name) => this._ownerName = name;
  set setOwnerUid(String uid) => this._ownerUid = uid;
  set setPostId(String id) => this._postId = id;
  set setIsLiked(bool value) => this.isLiked = value;
  set setAge(String age) => this._age = age;
  set setPostContents(Map<String, dynamic> contents) =>
      this._postContents = contents;
  set setQuiz(Map<String, dynamic> quiz) => this._quiz = quiz;

  // Increment the view count on a post everytime someone clicks on a post
  Future<void> incrementPostViewCount() async {
    try {
      await Firestore.instance
          .collection("lessons")
          .document(getPostId)
          .updateData({"views": FieldValue.increment(1)});
    } catch (error) {
      print("InrementPostViewCount error");
    }
  }

  /*
    Serialize the quix
  */

  /// Toggle the like button, marking it a favorite
  Future<void> toggleBookmarkButton(String uid) async {
    print("POST ID " + getPostId);
    final oldValue = this.isLiked;
    this.isLiked = !this.isLiked;
    print("TOGGLE");

    /// Convert the old value into its opposite
    notifyListeners();

    /// tell the consumer to change colors

    /// Add or remove the post from the user's favorites database
    try {
      if (this.isLiked) {
        /// if liked, then add the post id into users favorites
        await Firestore.instance
            .collection("users")
            .document(uid)
            .collection("favorites")
            .document(getPostId)
            .setData({});

        // Increment the likes count on the post
        await Firestore.instance
            .collection("lessons")
            .document(getPostId)
            .updateData({"likes": FieldValue.increment(1)});
      } else {
        // if unlike, remove the post from user favorites
        await Firestore.instance
            .collection("users")
            .document(uid)
            .collection("favorites")
            .document(getPostId)
            .delete();

        // Decrement the likes count on the post
        await Firestore.instance
            .collection("lessons")
            .document(getPostId)
            .updateData({"likes": FieldValue.increment(-1)});
      }
    } catch (error) {
      /// if there was an error, change the value back
      this.isLiked = oldValue;
      notifyListeners();
    }
  }

  /// Convert the contents into a Widget List that can be displayed on the screen
  List<Widget> constructPostWidgetList(Size screenSize) {
    List<Widget> contentToShowOnScreen = [];
    var postFieldType = [
      "introduction",
      "body 1",
      "body 2",
      "body 3",
      "conclusion"
    ];

    /// Map<String, Map<String, String>> from database
    var postContentList = this._postContents;
    contentToShowOnScreen.add(buildImage(
        this._imageUrl, this._title, screenSize.height, screenSize.width));
    contentToShowOnScreen.add(SizedBox(
      height: 30,
    ));

    /// For each value in the list, build the paragraph
    for (var type in postFieldType) {
      contentToShowOnScreen
          .add(buildParagraph(postContentList[type], screenSize.width));
      contentToShowOnScreen.add(SizedBox(
        height: 20,
      ));
    }

    return contentToShowOnScreen;
  }
}
