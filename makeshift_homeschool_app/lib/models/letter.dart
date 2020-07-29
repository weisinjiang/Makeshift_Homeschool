import 'package:cloud_firestore/cloud_firestore.dart';

class Letter {
  Map<String, String> contents;
  String id;

  Letter({this.id}) {
    this.contents = {};
  }

  /// Pass in the Documentsnapshot from Firestore and parse it for the data
  set setAllData(DocumentSnapshot data) {
    for (var i = 0; i < 5; i++) {
      this.contents["reason" + i.toString()] = data["reason" + i.toString()];
    }
    this.contents["intro"] = data["intro"];
    this.contents["body"] = data["body"];
    this.contents["conclusion"] = data["conclusion"];
  }

  /// Get the reason associated to the reason number
  /// 0-4
  String getReason(String reasonNum) {
    return this.contents["reason" + reasonNum];
  }

  get getIntro => this.contents["intro"];
  get getBody => this.contents["body"];
  get getConclusion => this.contents["conclusion"];
  get getId => this.id;
}
