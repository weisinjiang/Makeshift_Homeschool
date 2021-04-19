import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class Student {
  String _uid;
  String _profilepicture;
  String _username;

  Student() {
    this._uid = null;
    this._profilepicture = null;
    this._username = null;
  }

  set setUid(String uid) => this._uid = uid;
  set setUsername(String username) => this._username = username;
  set setProfilepicture(String profilepicture) =>
      this._profilepicture = profilepicture;
}
