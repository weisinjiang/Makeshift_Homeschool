import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';

class PostFeedProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance; // connect to firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Post> _posts = []; //post list to be shown on the feed
  List<Post> _userPosts = [];
  List<Post> _approvalNeeded = [];
  final String uid;
  
  PostFeedProvider(this.uid, this._posts);

  // Get the posts, not a ref to _post but a deep copy of it
  ///[...] does this
  List<Post> get getPosts => [...this._posts];
  List<Post> get getUserPosts => [..._userPosts];
  List<Post> get getApprovalNeeded => [..._approvalNeeded];

  Future<void> deletePost(String postId) async {
    /// First remove it from the database and the image from storage
    await _database.collection("lessons").doc(postId).delete();
    await _storage.ref().child("lessons").child(postId).delete();

    /// then delete it from the user's page
    for (var i = 0; i < _userPosts.length; i++) {
      if (_userPosts[i].getPostId == postId) {
        _userPosts.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }

  void markAsComplete(String postId) {
    for (var i = 0; i < getPosts.length; i++) {
      if (this._posts[i].getPostId == postId) {
        this._posts[i].setHasCompleted = true;
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
    Method gets posts from the "Approval Required" database.
    Used for Principle to retrieve posts that needs approval before adding
    it to the database

    if teacher, then fetch the tutor posts that have been approved by
    the principle
  */

  Future<void> fetchInReviewPosts(Reviewer reviewer) async {
    try {
      QuerySnapshot fetchedData;
      if (reviewer == Reviewer.principle) {
        fetchedData =
            await _database.collection("approval required").get();
      } else if (reviewer == Reviewer.teacher) {
        fetchedData = await _database.collection("review").get();
      }

      List<DocumentSnapshot> allDocuments = fetchedData.docs;
      List<Post> serializedPosts = [];

      // serialize all documents and make them into Post objects
      allDocuments.forEach((doc) {
        print(doc);
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
        post.setPostId = doc.id;
        post.setQuiz = doc["quiz"];
        post.setOwnerEmail = doc["ownerEmail"];
        post.setNumApprovals = doc["approvals"];
        serializedPosts.add(post); // add to local list
      });

      this._approvalNeeded = serializedPosts;
      notifyListeners();
    } catch (error) {
      print("something went wrong");
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
    QuerySnapshot inReviewPosts; // users posts that is in review

    try {
      if (query == "all") {
        // gets all the posts from lessons
        result = await _database.collection("lessons").get();
      } else {
        // otherwise get the users posts only from lessons
        result = await _database
            .collection("lessons")
            .where("ownerUid", isEqualTo: uid)
            .get();

        // Fetch documents that is currently in review
        inReviewPosts = await _database
            .collection("review")
            .where("ownerUid", isEqualTo: uid)
            .get();
      }

      // get all the documents from the query
      List<DocumentSnapshot> allPostDocuments = result.docs;

      // If there are any in review posts, add them to the collection
      if (inReviewPosts != null) {
        inReviewPosts.docs.forEach((doc) {
          allPostDocuments.add(doc);
        });
      }

      // get user's favorite list so isLiked can be set to true
      List<String> favoritesList = await fetchUsersFavoritesList(this.uid);
      List<String> completedLessons =
          await fetchUsersCompletedLessonsList(this.uid);

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
        post.setPostId = doc.id;
        post.setQuiz = doc["quiz"];
        post.setOwnerEmail = doc["ownerEmail"];
        // post does not need approval if it is in Lessons collection
        // if the post is a favorite
        if (favoritesList.contains(doc.id)) {
          post.setIsLiked = true;
        }
        if (completedLessons.contains(doc.id)) {
          post.setHasCompleted = true;
        }

        // Some post may not have videos because it is an earlier post, before we had videos
        try {
          String videoID = doc["videoID"];
          debugPrint("Video Link Found");
          post.setVideoID = videoID;
        } catch(error) {
          //post.setVideoUrl = "null";
          debugPrint("No video");
        }
        data.add(post);
      });

      // assign the list of data into the class variable
      if (query == "all") {
        this._posts = data;
      } else {
        this._userPosts = data;
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  /*
    Filters the post list and returns only the posts by the upper and lower
    bound ages.
  */

  List<Post> filterPostAgeBetween({int upperInclusive, int lowerInclusive}) {
    List<Post> filtered = getPosts.where((post) {
      int age = int.parse(post.getAge);
      if (age >= lowerInclusive && age <= upperInclusive) {
        return true;
      }
      return false;
    }).toList();

    return filtered;
  }

  /*
    Filters the post list and returns only the posts by the upper and lower
    bound ages.
  */

  List<Post> filterPostAgeFrom({int targetAge, bool greaterThanAge}) {
    List<Post> filtered = getPosts.where((post) {
      int age = int.parse(post.getAge);

      // if age should be greater than the target age
      if (greaterThanAge) {
        if (age > targetAge) {
          return true;
        }
        return false;
        // if age is less than the target age
      } else {
        if (age < targetAge) {
          return true;
        }
        return false;
      }
    }).toList();

    return filtered;
  }

  /*
    Gets the most bookmarked posts
    @take - amount of posts you want to show
  */
  List<Post> getMostBookmarkedPost(int take) {
    List<Post> allPosts = getPosts;
    if (allPosts.length == 0) {
      return null;
    }
    // Sort the list in decending order
    allPosts.sort((Post postB, Post postA) {
      int postBLikes = postB.getLikes;
      int postALikes = postA.getLikes;
      return postALikes.compareTo(postBLikes);
    });

    return allPosts.take(take).toList();
  }

/*
    Gets the most viewed posts
    @take - amount of posts you want to show
  */
  List<Post> getMostViewedPost(int take) {
    List<Post> allPosts = getPosts;
    if (allPosts.length == 0) {
      return null;
    }
    // Sort the list in decending order
    allPosts.sort((Post postB, Post postA) {
      int postBViews = postB.getViews;
      int postAViews = postA.getViews;
      return postAViews.compareTo(postBViews);
    });
    return allPosts.take(take).toList();
  }

  /*
    Gets the id of the user's favorite post
  */

  Future<List<String>> fetchUsersFavoritesList(String uid) async {
    List<String> favoritesList = [];

    QuerySnapshot snapshot = await _database
        .collection("users")
        .doc(uid)
        .collection("favorites")
        .get();

    // docs is of type QueryDocumentSnapshot
    List<DocumentSnapshot> allDocuments = snapshot.docs;
    allDocuments.forEach((document) {
      favoritesList.add(document.id);
    });
    return favoritesList;
  }

  /*
    Gets a list of ids for lessons that user's completed 
  */

  Future<List<String>> fetchUsersCompletedLessonsList(String uid) async {
    QuerySnapshot snapshot = await _database
        .collection("users")
        .doc(uid)
        .collection("completed lessons")
        .get();

    List<DocumentSnapshot> allDocuments = snapshot.docs;

    // for each document, convert it to a id and return the list
    return allDocuments.map((document) => document.id).toList();
  }
}
