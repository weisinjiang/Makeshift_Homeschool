import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';

class Post with ChangeNotifier {
  int likes; // Database stored as a string, needs to convert
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

  Post() {
    this.likes = 0;
    this._title = null;
    this._imageUrl = null;
    this._createdOn = null;
    this._ownerName = null;
    this._ownerUid = null;
    this._postContents = null;
    this._postId = null;
    this._age = "0";
    this.isLiked = false;

    /// post is not liked initially
  }

  //Getters
  int get getLikes => this.likes;
  String get getTitle => this._title; // First in array is title
  String get getImageUrl => this._imageUrl;
  String get getCreatedOn => this._createdOn;
  String get getOwnerName => this._ownerName;
  String get getOwnerUid => this._ownerUid;
  String get getPostId => this._postId;
  String get getAge => this._age;
  String get getIntroduction => this._postContents["introduction"];
  String get getBody1 => this._postContents["body 1"];
  String get getBody2 => this._postContents["body 2"];
  String get getBody3 => this._postContents["body 3"];
  String get getConclusion => this._postContents["conclusion"];
  
  Map<String, dynamic> get getPostContents => this._postContents;

  //Setters
  set setLikes(int likes) => this.likes = likes;
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

  /// Toggle the like button, marking it a favorite
  Future<void> toggleLikeButton(String uid, String postID) async {
    print("POST ID " + postID);
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
            .document(postID)
            .setData({});
      } else {
        /// if unlike, remove the post from user favorites
        await Firestore.instance
            .collection("users")
            .document(uid)
            .collection("favorites")
            .document(postID)
            .delete();
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
    contentToShowOnScreen
        .add(buildImage(this._imageUrl, screenSize.height, screenSize.width));

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
