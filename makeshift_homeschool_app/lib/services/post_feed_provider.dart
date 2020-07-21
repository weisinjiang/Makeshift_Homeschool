import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

class PostFeedProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // connect to firestore
  List<Post> _posts = []; //post list to be shown on the feed

  PostFeedProvider(this._posts);

  // Get the posts, not a ref to _post but a deep copy of it
  ///[...] does this
  List<Post> get getPosts => [..._posts];

  Stream<QuerySnapshot> lessonsCollectionStream() {
    print("STREAM CALLED");
    return _database.collection("lessons").snapshots();
  }

  Future<void> getPostsFromDatabase() async {
    QuerySnapshot result = await _database.collection("lessons").getDocuments();
    List<Post> data = [];
    List<DocumentSnapshot> allDocuments = result.documents;
    allDocuments.forEach((doc) async {
      Post post = Post();
      post.setCreatedOn = doc["createdOn"];
      post.setImageUrl = doc["imageUrl"];
      post.setLikes = doc["likes"];
      post.setOwnerName = doc["ownerName"];
      post.setOwnerUid = doc["ownerUid"];
      post.setPostContents = doc["postContents"];

      data.add(post);
      print("POST EXECUTED"); //!!!!!!!!
    });
    _posts = data;
    notifyListeners();
  }
}
