import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/widgets/new_video_widgets.dart';

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

    //^ Text Editing Controllers
    this._newVideoFormControllers = [
      TextEditingController(), // title
      TextEditingController(), // videoURL
      TextEditingController(), // discription
      TextEditingController(), // imageURL
    ];

    //^ Widget TextFields to display when uploading new video ~('u')~
    this._newVideoForms = [
      videoTitle(_newVideoFormControllers[0]),
      videoURL(_newVideoFormControllers[1]),
      description(_newVideoFormControllers[2]),
      //! To-do... Add place to add the video thumbnail (possibly find a way to get YouTube video thumbnail)
    ];
  }

  //^ Getters for variables
  List<Widget> get getNewVideoWidgetList => this._newVideoForms;
  List<TextEditingController> get getNewVideoFormControllers =>
      this._newVideoFormControllers;

  //^ Get data from TextEditingControllers
  List<String> getVideoControllerTextDataAsList() {
    List<String> controllerVideoTextData = []; //& text data to return

    this._newVideoFormControllers.forEach((controller) {
      //& go through each
      controllerVideoTextData.add(controller.text);
    });

    return controllerVideoTextData;
  }

  // check that the controllers are filled and we can post it
  // The isEdit parameter changes what we check for if someone is editing their post
  bool canPost({bool isEdit}) {
    var canPost = true;

    //^ If TextFields are empty, you cannot post
    //! To-do... When finished implamenting image, add if statement to make sure you cannot post if you haven't provided image

    this._newVideoFormControllers.forEach((controller) {
      if (controller.text.isEmpty) {
        /// if controller is empty, cant post
        canPost = false;
      }
    });

    return canPost;
  }

  // Method that posts the data. We need the users name, the number of lessons they created
  // their user level and their email from the Auth Widget and add this to our post data
  Future<void> post(
      {String uid,
      String name,
      int lessonCreated,
      String userLevel,
      String email}) async {
    //^ Add lesson created when video is posted
    lessonCreated++;

    //! To-do...create new collection for video approvals

    // //^ Referce to document the post will go into
    DocumentReference databaseRef;

    // //^ If the user is a Tutor, needs approval
    // if (userLevel == "Tutor") {
    //   databaseRef = _database.collection("approval required").doc();
    // }
    // //^ If user is teach or above, add to lessons (no approval required)
    // else {
    //   databaseRef = _database.collection("lessons").doc();
    // }

    //^ Construct all the data from the TextEditingControllers
    var postContentsList = getVideoControllerTextDataAsList();
    var newPostTitle = postContentsList[0];

    //^ Post content (organized)
    var videoContentAsMap = {
      "title": postContentsList[0],
      "videoURL": postContentsList[1],
      "description": postContentsList[2],
    };

    //! To-do...add field to store image in the database

    //^ data needed to make new video
    var newVideo = {
      "imageURL": null, //! To-do...add image functionality
      "ownerEmail": email,
      "ownerName": name,
      "ownerUid": uid,
      "videoContent": videoContentAsMap,
      "videoId": databaseRef.id,
      "approvals": 0,
    };

    //^ Add data to empty document
    await databaseRef.set(newVideo);

    //^ Increment users lessonsCreated if they aren't a Tutor
    //^ If Tutors video is reviewed, increment lessonsCreated
    if (userLevel != "Tutor") {
      lessonCreated++;
      await _database
          .collection("users")
          .doc(uid)
          .update({"lesson_created": lessonCreated});
    }
  }

  //&>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<&\\
  //&                    UPDATE POST                   &\\
  //&>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<&\\

  // Update the post. We need access the video feed provider bc we need to update the user's local copy of their
  // post by calling provider.updateUserPost()
  Future<void> update({VideoPost postData, VideoFeedProvider provider}) {
    throw UnimplementedError();
  }
}
