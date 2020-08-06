import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';
import 'package:makeshift_homeschool_app/models/letter.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';

/// This is a provider that deals with Bootcamp data
/// It gets the activities avaliable and it saves bootcamp letters to the users
/// database

class BootCampDatabase {
  /// Firestore Instances
  final Firestore _database = Firestore.instance;
  CollectionReference _bootcampRef;

  /// On create, the database reference will be bootcamp
  BootCampDatabase() {
    this._bootcampRef = _database.collection("bootcamp");
  }

  /// Gets the the list of boot camp activities currently in the database and
  /// create a BootCampActivity object. It needs a id first because the id will
  /// match the id of bootcamp activity name
  Future<List<BootCampActivity>> getBootCampActivities() async {
    List<BootCampActivity> activities = []; // to return
    var snapshot = await _bootcampRef.getDocuments(); // get all lessons
    var allDocuments = snapshot.documents;
    allDocuments.forEach((doc) {
      // for each, create a boot camp object
      var activity = BootCampActivity(id: doc.documentID); // needs id first
      activity.setData = doc; // set the rest of the data
      activities.add(activity);
    });

    return activities;
  }

  /// Get the name of bootcamp lessons for Bootcamp overview screen
  /// Takes in a list of BootCampActiviy and just extract the id into a list
  /// of strings
  List<String> getBootCampActivityNames(List<BootCampActivity> list) {
    List<String> names = [];
    list.forEach((element) {
      names.add(element.id);
    });
    return names;
  }

   Future<void> saveToUserProfile(
      String uid, String activityID,List<String> userResponse) async {
    await _database
        .collection("users")
        .document(uid)
        .collection("Bootcamp")
        .document(activityID)
        .setData({"userResponse": userResponse});
  }

  /// When users are finished with typing their answers to the bootcamp lessons
  /// Access the "bootcamp" collections in the users collection and set the data
  // Future<void> saveToUserProfile(
  //     String uid, String activityID, Map<String, String> letter) async {
  //   await _database
  //       .collection("users")
  //       .document(uid)
  //       .collection("Bootcamp")
  //       .document(activityID)
  //       .setData(letter);
  // }

  Future<List<Letter>> getSavedLetters(String uid) async {
    List<Letter> letterList = [];
    var snapshot = await _database
        .collection("users")
        .document(uid)
        .collection("Bootcamp")
        .getDocuments();
    var allDocuments = snapshot.documents;

    allDocuments.forEach((doc) {
    
      Letter letter = Letter(id: doc.documentID);
      letter.setAllData = doc;
      letterList.add(letter);
    });

    return letterList;
  }

  List<String> getLetterIds(List<Letter> letterList) {
    List<String> idList = [];

    letterList.forEach((letter) {
      idList.add(letter.getId);
    });

    return idList;
  }
}
