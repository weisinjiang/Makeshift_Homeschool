import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

class PostFeedProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // connect to firestore

  List<Post> _posts = []; //post list to be shown on the feed
  List<Post> _userPosts = [];
  final String uid;

  PostFeedProvider(this.uid, this._posts);

  // Get the posts, not a ref to _post but a deep copy of it
  ///[...] does this
  List<Post> get getPosts => [..._posts];
  List<Post> get getUserPosts => [..._userPosts];

  Stream<QuerySnapshot> lessonsCollectionStream() {
    print("STREAM CALLED");
    return _database.collection("lessons").snapshots();
  }

  Future<void> fetchUserPostsFromDatabase() async {
    /// This goes through lessons and gets the users post
    QuerySnapshot result = await _database
        .collection("lessons")
        .where("ownerUid", isEqualTo: uid)
        .getDocuments();
    List<DocumentSnapshot> allDocuments = result.documents;
    print("DOCUMENT LENGTH: " + allDocuments.length.toString());

    List<Post> data = [];

    /// For each document, I am creating a new post object for it.
    allDocuments.forEach((doc) {
      Post post = Post();
      post.setCreatedOn = doc["createdOn"];
      post.setAge = doc["age"];
      post.setTitle = doc["title"];
      post.setImageUrl = doc["imageUrl"];
      post.setLikes = doc["likes"];
      post.setOwnerName = doc["ownerName"];
      post.setOwnerUid = doc["ownerUid"];
      post.setPostContents = doc["postContents"];
      post.setPostId = doc.documentID;
      data.add(post);
    });
    _userPosts = data;
    notifyListeners();
  }

  Future<void> fetchPostsFromDatabase() async {
    QuerySnapshot result = await _database.collection("lessons").getDocuments();
    List<Post> data = [];
    List<DocumentSnapshot> allPostDocuments =
        result.documents; // all post documents

    List<String> favoritesList = await fetchUsersFavoritesList(this.uid);

    allPostDocuments.forEach((doc) async {
      Post post = Post();
      post.setCreatedOn = doc["createdOn"];
      post.setAge = doc["age"];
      post.setTitle = doc["title"];
      post.setImageUrl = doc["imageUrl"];
      post.setLikes = doc["likes"];
      post.setOwnerName = doc["ownerName"];
      post.setOwnerUid = doc["ownerUid"];
      post.setPostContents = doc["postContents"];
      post.setPostId = doc.documentID;

      if (favoritesList.contains(doc.documentID)) {
        post.setIsLiked = true;
      }
      data.add(post);
    });
    this._posts = data;
    notifyListeners();
  }

  Future<List<String>> fetchUsersFavoritesList(String uid) async {
    List<String> favoritesList = [];

    QuerySnapshot snapshot = await _database
        .collection("users")
        .document(uid)
        .collection("favorites")
        .getDocuments();

    List<DocumentSnapshot> allDocuments = snapshot.documents;
    allDocuments.forEach((document) {
      favoritesList.add(document.documentID);
    });
    return favoritesList;
  }
}
