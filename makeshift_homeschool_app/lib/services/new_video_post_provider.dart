

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';

class NewVideoPostProvider {

  // Connection to Firestore
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  // Holds widgets that builds the video screen 
  List<Widget> _newVideoForms;

  // Holds all the controllers for textboxes
  List<TextEditingController> _newVideoFormControllers;

  // Constructor
  NewVideoPostProvider({VideoPost postData}) {
    // Add controllers and widgets and assign them into variables here.
  }

  // check that the controllers are filled and we can post it
  // The isEdit parameter changes what we check for if someone is editing their post
  bool canPost({bool isEdit}) {
    throw UnimplementedError(); // Delete this when implementing
  }


  // Method that posts the data. We need the users name, the number of lessons they created
  // their user level and their email from the Auth Widget and add this to our post data
  Future<void> post({String uid, String name, int lessonCreated, String userLevel, String email}) async {
    throw UnimplementedError();
  }

  // Update the post. We need access the video feed provider bc we need to update the user's local copy of their
  // post by calling provider.updateUserPost()
  Future<void> update({VideoPost postData, VideoFeedProvider provider}) {
    throw UnimplementedError();
  }


}