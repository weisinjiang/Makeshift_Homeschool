import 'dart:convert';
import 'dart:io';

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

  bool isBootcampComplete(List<TextEditingController> controllers) {
    for (var i = 0; i < controllers.length; i++) {
      if (controllers[i].text.isEmpty || controllers[i].text == "") {
        return false;
      }
    }
    return true;
  }

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
      Map<String, dynamic> user, String activityID, String userResponse) async {
    await _database
        .collection("users")
        .document(uid)
        .collection("bootcamp")
        .document(activityID)
        .setData({"userResponse": userResponse});

    // send an email to user's email
    await sendBootcampCompleteEmail(
        email: user["email"],
        activityId: activityID,
        username: user["username"],
        userResponse: userResponse);
  }

  // Method send an email to the user's email about the compleition of a bootcamp
  Future<void> sendBootcampCompleteEmail(
      {String email,
      String username,
      String activityId,
      String userResponse}) async {
    String url =
        "https://us-east4-makeshift-homeschool-281816.cloudfunctions.net/bootcamp_complete_email";

    // Payload data the email needs
    Map<String, dynamic> jsonData = {
      "data": {
        "email": email,
        "username": username,
        "activityId": activityId,
        "userResponse": userResponse
      }
    };

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    // describes the type of data of the http request
    request.headers.set('content-type', 'application/json');
    // encode the json and add it to the http request
    request.add(utf8.encode(json.encode(jsonData)));
    // calls the request and returns a val, then close it
    HttpClientResponse response = await request.close();
    // reponse of the request
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
  }
}
