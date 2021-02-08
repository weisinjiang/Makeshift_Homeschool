import 'package:flutter/material.dart';

/// Video Object for video posts

class VideoPost with ChangeNotifier {
  int views; 
  String link;
  String createdOn;
  String title;
  String owner;
  String ownerEmail;
  String postID;
  bool isLiked;


  VideoPost({
    this.views, this.createdOn, this.link, this.owner, this.ownerEmail, this.title, this.isLiked = false, this.postID}
  );

  // Getters
  int get getViews => this.views;
  String get getLink => this.link;
  String get getCreatedOn => this.createdOn;
  String get getTitle => this.title;
  String get getOwnerEmail => this.ownerEmail;
  String get getOwner => this.owner;
  String get getPostID => this.postID;

  // Increment view count
  Future<void> incrementPostViewCount() async {
    throw UnimplementedError();
  }

  // Add this video to the user's bookmark list
  // uid -> the user's id on firebase
  Future<void> toggleBookmarkButton(String uid) async {
    throw UnimplementedError();
  }


}