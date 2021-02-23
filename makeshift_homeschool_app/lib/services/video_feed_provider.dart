import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';

/// Class takes care of getting data from the database and making a Video object out of it
/// ChangeNotider is for when someone updates the post and it needs to be changed immediately
/// on your computer.

class VideoFeedProvider with ChangeNotifier {
  // Reference to data
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Holds all video posts
  List<VideoPost> videos = [];
  List<Post> _userPosts = [];
  final String uid;

  // Constructor
  VideoFeedProvider({this.uid, this.videos});

  // Getters of the video posts
  //^ Makes deep copy of posts (using ...)
  List<VideoPost> get getVideoPosts => [...this.videos];

  // Delete a Video post (if this is called from user's profile)
  Future<void> deletePost({String postID}) async {
    //^ Remove video from database
    await _database.collection("videos").doc(postID).delete();
    await _storage.ref().child("videos").child(postID).delete();
    
    //^ Delete from users page
    //! To-do ... display video in users posts and delete from users post when post is deleted
  }

  // When a user updates their post, their local copy of the post
  // is not updated. this method will update the local copy when they send their
  // update to Firebase so that we dont waste money on retirveing it agaion and having to refetch everything
  void updateUserPost(
      {String postID,
      Map<String, String> postContents,
      String title,
      String age}) {
    for (var i = 0; i < _userPosts.length; i++) {
      // if (_userPosts[i].getPostId)
    }
  }

  // This is when you get posts.
  // We call this function with isUser == True when this is called in the user's profile page
  // Otherwise, it is called from the root screen and isUser == False by default
  Future<void> fetchPosts({bool isUser = false}) {
    throw UnimplementedError();
  }
}
