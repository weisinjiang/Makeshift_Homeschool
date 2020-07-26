import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';

class BootCampData {
  /// Firestore Instances
  final Firestore _database = Firestore.instance;
  CollectionReference _bootcampRef;
  CollectionReference _userBootCampCollectionRef;

  BootCampData() {
    this._bootcampRef = _database.collection("bootcamp");
  }

  Future<List<BootCampActivity>> getBootCampActivities() async {
    List<BootCampActivity> activities = [];
    var snapshot = await _bootcampRef.getDocuments();
    var allDocuments = snapshot.documents;
    allDocuments.forEach((doc) {
      var activity = BootCampActivity(id: doc.documentID);
      activity.setData = doc;
      activities.add(activity);
    });

    return activities;
  }

  List<String> getBootCampActivityNames(List<BootCampActivity> list) {
    List<String> names = [];
    list.forEach((element) {
      names.add(element.id);
    });
    return names;
  }

  Future<void> saveToUserProfile(String uid, String activityID, Map<String, String> letter) async{
    await _database
        .collection("users")
        .document(uid)
        .collection("Bootcamp")
        .document(activityID)
        .setData(letter);
  }
}
