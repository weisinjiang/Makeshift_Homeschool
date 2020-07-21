import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

class PostFeedProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // connect to firestore
  List<Post> _posts = []; //post list to be shown on the feed

  // Get the posts, not a ref to _post but a deep copy of it
  ///[...] does this
  List<Post> get getPosts => [...this._posts];

  Future<void> getPostsFromDatabase() async {
    QuerySnapshot result = await _database.collection("lessons").getDocuments();
    List<DocumentSnapshot> allDocuments = result.documents;
    allDocuments.forEach((doc) async {
      Post post = Post();
      post.setCreatedOn = doc["createdOn"];
      post.setImageUrl = doc["imageUrl"];
      post.setLikes = doc["likes"];
      post.setOwnerName = doc["ownerName"];
      post.setOwnerUid = doc["ownerUid"];
      post.setPostContents = doc["postContents"];

      this._posts.add(post);
      print("POST EXECUTED"); //!!!!!!!! 
    });
    notifyListeners();
    return this._posts;
  }
}