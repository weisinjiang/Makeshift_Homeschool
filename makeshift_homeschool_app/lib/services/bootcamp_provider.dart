import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_lesson.dart';


/// This is a provider that deals with Bootcamp data
/// It gets the activities avaliable and it saves bootcamp letters to the users
/// database

class BootCampProvider with ChangeNotifier {
  final uid;

  /// Firestore Instances
  final Firestore _database = Firestore.instance;
  CollectionReference _userBootCampDatabaseRef;
  List<BootCampLesson> userLessons;

  /// On create, the database reference will be bootcamp
  BootCampProvider(this.uid, this.userLessons) {
    this._userBootCampDatabaseRef =
        _database.collection("users").document(uid).collection("bootcamp");

  }

  List<BootCampLesson> get getUserLessons => [...this.userLessons];

  /// Gets all the users saved lessons from bootcamp
  Future<void> fetchUserBootCampLessons() async {
    List<BootCampLesson> documentData = [];

    await this._userBootCampDatabaseRef.getDocuments().then((result) {
      var documentList = result.documents;
      documentList.forEach((document) {
        /// Get the document's id and the users response and add it to the
        /// map
        var documentId = document.documentID;
        var userResponse = document["userResponse"];
        var asMap = {documentId: userResponse};

        BootCampLesson lesson =
            BootCampLesson(id: documentId, content: userResponse);

        documentData.add(lesson);
      });
    });
    this.userLessons = documentData;
    notifyListeners();
  }

  /// When users complete a bootcamp, this saves their response into
  /// users -> uid -> bootcamp -> activityID
  Future<void> saveToUserProfile(
      String uid, String activityID, String userResponse) async {
    await _database
        .collection("users")
        .document(uid)
        .collection("bootcamp")
        .document(activityID)
        .setData({"userResponse": userResponse});
  }
}
