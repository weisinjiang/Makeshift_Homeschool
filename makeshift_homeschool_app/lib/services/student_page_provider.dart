import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Student {
  String _uid;
  String _profilepicture;
  String _username;
  List _posts;
  List _videos;

  Student() {
    this._uid = "";
    this._profilepicture = "";
    this._username = "";
    this._posts = [];
    this._videos = [];
  }

  set setUid(String uid) => this._uid = uid;
  set setUsername(String username) => this._username = username;
  set setProfilepicture(String profilepicture) =>
      this._profilepicture = profilepicture;
  set setPosts(List posts) => this._posts = posts;
  set setVideos(List videos) => this._videos = videos;
}

// class StudentsPageProvider {
//   final FirebaseFirestore _database =
//       FirebaseFirestore.instance; // connect to firestore

//   Future<void> fetchUsers() async {
//     try {
//       await _database
//           .collection("users")
//           .where("uid")
//           .where("photoURL")
//           .where("username")
//           .get();
//     } catch (e) {
//       print(e);
//     }
//   }
// }
