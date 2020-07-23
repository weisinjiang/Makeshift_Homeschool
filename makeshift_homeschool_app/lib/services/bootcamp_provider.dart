import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makeshift_homeschool_app/models/bootcamp_activity.dart';

class BootCampProvider {
  final Firestore _database = Firestore.instance;
  CollectionReference _bootcampRef;

  BootCampProvider() {
    this._bootcampRef = _database.collection("bootcamp");
  }

  // Future<List<String>> getDocumentsIdList() async {
  //   List<String> documentId = [];
  //   var snapshot = await _bootcampRef.getDocuments();
  //   snapshot.documents.forEach((doc) {
  //     documentId.add(doc.documentID);
  //   });

  //   return documentId;
  // }

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
}
