// This is an object that will contain all of the students information

import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';

class Student {
  String uid;
  String profilepicture;
  String username;
  List<Post> _posts;
  List<VideoPost> _videos;

  Student({this.uid, this.profilepicture, this.username}) {
    //^ to finish
    this._posts = null;
    this._videos = null;
  }

  set setUid(String uid) => this.uid = uid;
  set setUsername(String username) => this.username = username;
  set setProfilepicture(String profilepicture) =>
      this.profilepicture = profilepicture;
  set setPosts(List posts) => this._posts = posts;
  set setVideos(List videos) => this._videos = videos;

  // Container(
  //   child: Column(
  //     children: [
  //       CircleAvatar(
  //         child: Image.network(profilepicture),
  //       ),
  //       Text(username)
  //     ],
  //   ),
  // );
}
