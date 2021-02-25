import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';

/// Class takes care of getting data from the database and making a Video object out of it
/// ChangeNotider is for when someone updates the post and it needs to be changed immediately
/// on your computer.

class VideoFeedProvider with ChangeNotifier {
  // Reference to data
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  // Holds all video posts
  List<VideoPost> allVideoPosts = [];
  List<VideoPost> _userPosts = [];
  final String uid;

  // Constructor
  VideoFeedProvider({this.uid, this.allVideoPosts});

  // Getters of the video posts
  //^ Makes deep copy of posts (using ...)
  List<VideoPost> get getVideoPosts => [...this.allVideoPosts];
  List<VideoPost> get getUsersVideoPosts => [...this._userPosts];

  // Delete a Video post (if this is called from user's profile)
  Future<void> deletePost({String postID}) async {
    //^ Remove video from database
    await _database.collection("videos").doc(postID).delete();

    // Delete from user's page
    for (var i = 0; i < _userPosts.length; i++) {
      if (_userPosts[i].getLessonID == postID) {
        _userPosts.removeAt(i);
        notifyListeners();
        break;
      }
    }

  }

  // When a user updates their post, their local copy of the post
  // is not updated. this method will update the local copy when they send their
  // update to Firebase so that we dont waste money on retirveing it agaion and having to refetch everything
  void updateUserPost({String postID, String videoID, String title, String description, int age}) {

    for (var i = 0; i < _userPosts.length; i++) {
      if (_userPosts[i].getLessonID == postID) {
        _userPosts[i].setDescription = description;
        _userPosts[i].setTitle = title;
        _userPosts[i].setVideoID = videoID;
        _userPosts[i].setAge = age;
        break;
      }
    }
  }

  // This is when you get posts.
  // We call this function with isUser == True when this is called in the user's profile page
  // Otherwise, it is called from the root screen and isUser == False by default
  Future<void> fetchVideoPostsFromDatabase() async{
    try {
      QuerySnapshot fetchedDocuments = await _database.collection("videos").get();
      List<DocumentSnapshot> allVideoDocuments = fetchedDocuments.docs;
      List<String> favoritesList = await fetchUsersFavoritesList(this.uid);

      List<VideoPost> videoPosts = [];

      // For each of the documents, get the data and set them into a VideoPost object
      allVideoDocuments.forEach((doc) {
        print(doc.id);
        // VideoPost post = VideoPost(
        //   description: doc["description"],
        //   videoID: doc["videoID"],
        //   owner: doc["ownerName"],
        //   ownerEmail: doc["ownerEmail"],
        //   title: doc["title"],
        //   views: int.parse(doc["views"]),
        //   likes: int.parse(doc["likes"]),
        //   age: int.parse(doc["age"]),
        //   createdOn: doc["createdOn"],
        //   lessonID: doc["lessonID"],
        //   isLiked: favoritesList.contains(doc["videoID"]) ? true : false
          
        // );
        VideoPost post = new VideoPost();
        post.setDescription = doc["description"];
        print("1");
        post.setVideoID = doc["videoID"];
        print("2");
        post.setOwnerName = doc["ownerName"];
        print("3");
        post.setOwnerEmail = doc["ownerEmail"];
        print("4");
        post.setTitle = doc["title"];
        print("5");
        post.setViews = doc["views"];
        print("6");
        post.setLikes = doc["likes"];
        print("7");
        post.setAge = doc["age"];
        print("8");
        post.setCreatedOn = doc["createdOn"];
        print("9");
        post.setLessonID = doc["lessonID"];
        print("10");
        if (favoritesList.contains(doc["videoID"])) {
          post.setIsLike = true;
        }

        // Add to video post list
        videoPosts.add(post);
       
      });
      this.allVideoPosts = videoPosts;
      notifyListeners();
    } catch (error) {
      print(error);
      print("Error fetching video Posts");
      
    }
  }

  // Fetches the user's posts from the database
  Future<void> fetchUserVideoPostsFromDatabase() async{
    try {
      QuerySnapshot fetchedDocuments = await _database.collection("videos").where("ownerUid", isEqualTo: uid).get();
      List<DocumentSnapshot> allVideoDocuments = fetchedDocuments.docs;
      List<String> favoritesList = await fetchUsersFavoritesList(this.uid);

      List<VideoPost> videoPosts = [];

      // For each of the documents, get the data and set them into a VideoPost object
      allVideoDocuments.forEach((doc) {
        print(doc.id);
        VideoPost post = VideoPost(
          description: doc["description"],
          videoID: doc["videoID"],
          owner: doc["ownerName"],
          ownerEmail: doc["ownerEmail"],
          title: doc["title"],
          views: doc["views"],
          likes: doc["likes"],
          age: int.parse(doc["age"]),
          createdOn: doc["createdOn"],
          lessonID: doc["lessonID"],
          isLiked: favoritesList.contains(doc["videoID"]) ? true : false
          
        );
        // Add to video post list
        videoPosts.add(post);
       
      });
      this._userPosts = videoPosts;
      notifyListeners();
    } catch (error) {
      print(error);
      print("Error fetching video Posts");
      VideoPost post = VideoPost(
          description: "Error Fetching",
          videoID: "Error Fetching",
          owner: "Error Fetching",
          ownerEmail: "Error Fetching",
          lessonID: "000",
          title: "Error Fetching",
          views: 0,
          likes: 0,
          age: 14
        );
        this._userPosts.add(post);
      
    }
  }
 
  ///Gets the id of the user's favorite post
  Future<List<String>> fetchUsersFavoritesList(String uid) async {
    List<String> favoritesList = [];

    QuerySnapshot snapshot = await _database
        .collection("users")
        .doc(uid)
        .collection("favorite videos")
        .get();

    // docs is of type QueryDocumentSnapshot
    List<DocumentSnapshot> allDocuments = snapshot.docs;
    allDocuments.forEach((document) {
      favoritesList.add(document.id);
    });
    return favoritesList;
  }

  /*
    Filters the post list and returns only the posts by the upper and lower
    bound ages.
  */

  List<VideoPost> filterPostAgeBetween({int upperInclusive, int lowerInclusive}) {
    List<VideoPost> filtered = getVideoPosts.where((post) {
      int age = post.getAge;
      if (age >= lowerInclusive && age <= upperInclusive) {
        return true;
      }
      return false;
    }).toList();

    print("filtered ${filtered.length}");
    return filtered;
  }

   
  ///Gets the most bookmarked posts
  ///@take - amount of posts you want to show
  
  List<VideoPost> getMostBookmarkedPost(int take) {
    List<VideoPost> allPosts = getVideoPosts;
    // Sort the list in decending order
    allPosts.sort((VideoPost postB, VideoPost postA) {
      int postBLikes = postB.getLikes;
      int postALikes = postA.getLikes;
      return postALikes.compareTo(postBLikes);
    });
    print("filtered ${allPosts.take(take).toList().length}");
    return allPosts.take(take).toList();
  }

   /*
    Filters the post list and returns only the posts by the upper and lower
    bound ages.
  */

  List<VideoPost> filterPostAgeFrom({int targetAge, bool greaterThanAge}) {
    List<VideoPost> filtered = getVideoPosts.where((post) {
      int age = post.getAge;

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
    print("filtered ${filtered.length}");
    return filtered;
  }

  /*
    Gets the most viewed posts
    @take - amount of posts you want to show
  */
  List<VideoPost> getMostViewedPost(int take) {
    List<VideoPost> allPosts = getVideoPosts;
    if (allPosts.length == 0) {
      return null;
    }
    // Sort the list in decending order
    allPosts.sort((VideoPost postB, VideoPost postA) {
      int postBViews = postB.getViews;
      int postAViews = postA.getViews;
      return postAViews.compareTo(postBViews);
    });
    return allPosts.take(take).toList();
  }

  ///Gets the most bookmarked posts
  ///@take - amount of posts you want to show
  
  List<VideoPost> getMostRecent10Posts() {
    List<VideoPost> allPosts = getVideoPosts;
    if (allPosts.length == 0) {
      return null;
    }
    // Sort the list in decending order
    allPosts.sort((VideoPost postB, VideoPost postA) {
      DateTime postBDate = DateTime.parse(postB.getRawCreatedOn);
      DateTime postADate = DateTime.parse(postA.getRawCreatedOn);
      return postADate.compareTo(postBDate);
    });

    return allPosts.take(10).toList();
  }
}
