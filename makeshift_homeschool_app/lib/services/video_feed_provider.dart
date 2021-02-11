import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';

/// Class takes care of getting data from the database and making a Video object out of it
/// ChangeNotider is for when someone updates the post and it needs to be changed immediately 
/// on your computer.

class VideoFeedProvider with ChangeNotifier {
  // Referenve to data
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  

  // Holds all video posts
  List<VideoPost> videos = [];
  final String uid;

  // Constructor
  VideoFeedProvider({this.uid, this.videos});

  // Getters of the video posts

  // Delete a Video post (if this is called from user's profile)
  Future<void> deletePost({String postID}) async {
    throw UnimplementedError();
  }  

  // When a user updates their post, their local copy of the post
  // is not updated. this method will update the local copy when they send their 
  // update to Firebase so that we dont waste money on retirveing it agaion and having to refetch everything
  void updateUserPost({String postID, Map<String, String> postContents, String title, String age}) {
    throw UnimplementedError();
  }

  // This is when you get posts. 
  // We call this function with isUser == True when this is called in the user's profile page
  // Otherwise, it is called from the root screen and isUser == False by default
  Future<void> fetchPosts({bool isUser = false}) {
    throw UnimplementedError();
  }
}