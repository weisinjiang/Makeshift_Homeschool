import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';

class PostFeedProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // connect to firestore

  List<Post> _posts = []; //post list to be shown on the feed
  List<Post> _userPosts = [];
  List<Post> _top5Likes = [];
  List<Post> _top5Viewed = [];
  final String uid;

  PostFeedProvider(this.uid, this._posts);

  // Get the posts, not a ref to _post but a deep copy of it
  ///[...] does this
  List<Post> get getPosts => [...this._posts];
  List<Post> get getUserPosts => [..._userPosts];
  List<Post> get getTop5Likes => [..._top5Likes];
  List<Post> get getTop5Viewed => [..._top5Viewed];

  Future<void> deletePost(String postId) async {
    /// First remove it from the database
    await _database.collection("lessons").document(postId).delete();

    /// then delete it from the user's page
    for (var i = 0; i < _userPosts.length; i++) {
      if (_userPosts[i].getPostId == postId) {
        _userPosts.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }

  /// Update the users post if the post got updated in new post provider's
  /// edit mode
  void updateUserPost(
      {String postId,
      Map<String, String> postContents,
      String title,
      String age,
      Map<String, dynamic> newQuiz}) {
    for (var i = 0; i < _userPosts.length; i++) {
      if (_userPosts[i].getPostId == postId) {
        _userPosts[i].setAge = age;
        _userPosts[i].setPostContents = postContents;
        _userPosts[i].setTitle = title;
        _userPosts[i].setQuiz = newQuiz;
        notifyListeners();
        break;
      }
    }
  }

  /*
    Method gets lessons from the database based on the query type and saves it
    into the class variable based on the param.
    @param query: what to query from lessons database
      "all" gets all posts and save to _posts
      "user" gets only user posts and save to _userPosts
      
  */
  Future<void> fetchPostsFromDatabase({String query}) async {
    QuerySnapshot result; // result of query

    try {
      if (query == "all") {
        // gets all the posts from lessons
        result = await _database.collection("lessons").getDocuments();
      } else {
        // otherwise get the users posts only from lessons
        result = await _database
            .collection("lessons")
            .where("ownerUid", isEqualTo: uid)
            .getDocuments();
      }

      // get all the documents from the query
      List<DocumentSnapshot> allPostDocuments = result.documents;
      // get user's favorite list so isLiked can be set to true
      List<String> favoritesList = await fetchUsersFavoritesList(this.uid);

      // serialize each document into a Post object and add it to data list
      List<Post> data = [];
      allPostDocuments.forEach((doc) {
        Post post = Post();
        post.setLikes = doc["likes"];
        post.setViews = doc["views"];
        post.setRating = doc["rating"].toDouble();
        post.setNumRaters = doc["raters"];
        post.setCreatedOn = doc["createdOn"];
        post.setAge = doc["age"];
        post.setTitle = doc["title"];
        post.setImageUrl = doc["imageUrl"];
        post.setLikes = doc["likes"];
        post.setOwnerName = doc["ownerName"];
        post.setOwnerUid = doc["ownerUid"];
        post.setPostContents = doc["postContents"];
        post.setPostId = doc.documentID;
        post.setQuiz = doc["quiz"];
        // if the post is a favorite
        if (favoritesList.contains(doc.documentID)) {
          post.setIsLiked = true;
        }
        data.add(post);
      });

      // assign the list of data into the class variable
      if (query == "all") {
        this._posts = data;
      } else {
        this._userPosts = data;
      }
      get5MostLikedPost();
      get5MostViewedPost();
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  void get5MostLikedPost() {
    List<Post> allPosts = this._posts;
    if (allPosts.length == 0) {
      return;
    }
    List<Post> top5Likes = [];
    // Sort the list in decending order
    allPosts.sort((Post postB, Post postA) {
      int postBLikes = postB.getLikes;
      int postALikes = postA.getLikes;
      //print("${postALikes.toString()}   ${postBLikes.toString()}");
      return postALikes.compareTo(postBLikes);
    });

    int limit = 0;
    if (allPosts.length > 5) {
      limit = 5;
    } else {
      limit = allPosts.length;
    }
    for (int i = 0; i < limit; i++) {
      top5Likes.add(allPosts[i]);
    }
    // get the first 5 most liked posts
    this._top5Likes = top5Likes;
  }

  void get5MostViewedPost() {
    List<Post> allPosts = getPosts;
    if (allPosts.length == 0) {
      return;
    }
    // Sort the list in decending order
    allPosts.sort((Post postB, Post postA) {
      int postBViews = postB.getViews;
      int postAViews = postA.getViews;
      return postAViews.compareTo(postBViews);
    });
    int limit = 0;

    if (allPosts.length > 5) {
      limit = 5;
    } else {
      limit = allPosts.length;
    }
    // get the first 5 most liked posts
    this._top5Viewed = allPosts.sublist(0, limit);
  }

  /*
    Gets the id of the user's favorite post
  */

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
