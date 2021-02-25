import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/widgets/post_widgets.dart';
import 'package:makeshift_homeschool_app/widgets/youtube_player.dart';

/// Video Object for video posts

class VideoPost with ChangeNotifier {
  int views;
  String videoID;
  String title;
  String lessonID;
  String owner;
  String ownerEmail;
  String description;
  String createdOn;
  bool isLiked;
  int likes;
  int age;

  VideoPost(
      {this.views,
      this.lessonID,
      this.videoID,
      this.age,
      this.owner,
      this.ownerEmail,
      this.title,
      this.isLiked = false,
      this.likes,
      this.createdOn,
      this.description});

  //^ Getters
  int get getViews => this.views;
  String get getLessonID => this.lessonID;
  String get getVideoID => this.videoID;
  String get getTitle => this.title;
  String get getOwnerEmail => this.ownerEmail;
  String get getOwner => this.owner;
  String get getPostID => this.lessonID;
  String get getDescription => this.description;
  int get getAge => this.age;
  int get getLikes => this.likes;
  String get getRawCreatedOn => this.createdOn;

  String getFormattedDateCreated() {
    DateTime date = DateTime.parse(this.createdOn);
    String formatted = "${date.month}-${date.day}-${date.year}";
    return formatted;
  }

  //^ Setters
  set setAge(int age) => this.age = age;
  set setViews(int views) => this.views = views;
  set setVideoID(String id) => this.videoID = id;
  set setTitle(String title) => this.title = title;
  set setDescription(String description) => this.description = description;
  set setOwnerName(String name) => this.owner = name;
  set setOwnerEmail(String email) => this.ownerEmail;
  set setLikes(int likes) => this.likes = likes;
  set setCreatedOn(String str) => this.createdOn = str;
  set setLessonID(String id) => this.lessonID = id;
  set setIsLike(bool boolean) => this.isLiked = boolean;
  // Increment view count
  Future<void> incrementPostViewCount() async {
    try {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(getPostID)
          .update({"views": FieldValue.increment(1)});
    } catch (error) {
      print("InrementPostViewCount error");
    }
  }

  // Add this video to the user's bookmark list
  // uid -> the user's id on firebase
  Future<void> toggleBookmarkButton(String uid) async {
    final oldValue = this.isLiked; // if something went wrong, revert it back
    this.isLiked = !this.isLiked; // invert the current like value

    /// Add or remove the post from the user's favorites database
    try {
      if (this.isLiked) {
        /// if liked, then add the post id into users favorites
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("favorite videos")
            .doc(getPostID)
            .set({});

        // update the bookmark icon's fill color
        notifyListeners();

        // Increment the likes count on the post
        await FirebaseFirestore.instance
            .collection("videos")
            .doc(getPostID)
            .update({"likes": FieldValue.increment(1)});
      } else {
        // if unlike, remove the post from user favorites
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("favorite videos")
            .doc(getPostID)
            .delete();

        notifyListeners();

        // Decrement the likes count on the post
        await FirebaseFirestore.instance
            .collection("videos")
            .doc(getPostID)
            .update({"likes": FieldValue.increment(-1)});
      }
    } catch (error) {
      /// if there was an error, change the value back
      this.isLiked = oldValue;
      notifyListeners();
      throw error;
    }
  }

  List<Widget> constructPostWidgetList(Size screenSize) {
    String youtubeImageURL = "https://img.youtube.com/vi/${this.videoID}/0.jpg";
    List<Widget> contentToShowOnScreen = [
      //buildImage(youtubeImageURL, this.title.toUpperCase(), screenSize.height, this.owner, screenSize.width),
      SizedBox(height: 30,),
      YoutubePlayerWidget(videoID: this.videoID, height: screenSize.height, width: screenSize.width,),
      SizedBox(height: 30,),
      buildParagraph(this.description, screenSize.width),
    ];

    return contentToShowOnScreen;
  }
}
