import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';

class Post with ChangeNotifier {
  int _likes;
  int _views;
  double _rating;
  int _raters;
  String _imageUrl;
  String _age;
  String _createdOn;
  String _ownerName;
  String _ownerUid;
  String _title;
  String _postId;
  String _ownerEmail;
  bool isLiked;
  // Subtitles and paragraphs in order from Firestore
  Map<String, dynamic> _postContents;
  Map<String, dynamic> _quiz;

  Post() {
    this._views = 0;
    this._likes = 0;
    this._raters = 0;
    this._rating = 0.0;
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
    this._ownerEmail = null;

    /// post is not liked initially
  }

  //Getters
  int get getLikes => this._likes;
  int get getViews => this._views;
  double get getRating => this._rating;
  int get getNumRaters => this._raters;
  String get getTitle => this._title; // First in array is title
  String get getImageUrl => this._imageUrl;
  String get getOwnerName => this._ownerName;
  String get getOwnerUid => this._ownerUid;
  String get getPostId => this._postId;
  String get getAge => this._age;
  String get getOwnerEmail => this._ownerEmail;

  // gets the date posted. Format it into month/day/year
  String getCreatedOn() {
    DateTime date = DateTime.parse(this._createdOn);
    String formatted = "${date.month}-${date.day}-${date.year}";
    return formatted;
  }

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
  set setRating(double rating) => this._rating = rating;
  set setNumRaters(int raters) => this._raters = raters;
  set setTitle(String title) => this._title = title;
  set setImageUrl(String url) => this._imageUrl = url;
  set setCreatedOn(String time) => this._createdOn = time;
  set setOwnerName(String name) => this._ownerName = name;
  set setOwnerUid(String uid) => this._ownerUid = uid;
  set setPostId(String id) => this._postId = id;
  set setIsLiked(bool value) => this.isLiked = value;
  set setAge(String age) => this._age = age;
  set setOwnerEmail(String email) => this._ownerEmail;
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

  // Returns a facial expression based on the ratings on a post
  Widget ratingsWidgetIcon() {
    double rating = getRating;
    if (rating <= 5.0 && rating > 4.0) {
      return Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
        size: 30,
      );
    } else if (rating <= 4.0 && rating > 3.0) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.lightGreen,
      );
    } else if (rating <= 3.0 && rating > 2.0) {
      return Icon(
        Icons.sentiment_neutral,
        color: Colors.amber,
        size: 30,
      );
    } else if (rating <= 2.0 && rating > 1.0) {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.redAccent,
        size: 30,
      );
    } else {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 30,
      );
    }
  }

  // Update the posts rating when a user completes it
  Future<void> updatePostRating({double userRating, String uid}) async {
    DocumentReference documentRef =
        Firestore.instance.collection("lessons").document(getPostId);

    // calculating new average
    double currentRating = getRating;
    int currentRaters = getNumRaters;
    double ratingTotal = currentRating * currentRaters;
    ratingTotal += userRating; // update new total
    currentRaters++; // 1 additional rating
    double newAverage = ratingTotal / currentRaters;
    try {
      // update the data
      await documentRef
          .updateData({"rating": newAverage, "raters": currentRaters});
    } catch (error) {
      print("Update Post Rating Error ${error.toString()}");
      throw error;
    }
  }

  /// Toggle the like button, marking it a favorite
  Future<void> toggleBookmarkButton(String uid) async {
    final oldValue = this.isLiked; // if something went wrong, revert it back
    this.isLiked = !this.isLiked; // invert the current like value

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

        // update the bookmark icon's fill color
        notifyListeners();

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

        notifyListeners();

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
      throw error;
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
