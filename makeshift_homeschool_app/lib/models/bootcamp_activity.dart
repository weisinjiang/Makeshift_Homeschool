import 'package:cloud_firestore/cloud_firestore.dart';

class BootCampActivity {
  Map<int, String> fiveResponse;
  String id;
  String image;
  Map<String, String> template;

  BootCampActivity({this.id}) {
    this.image = "";
    this.fiveResponse = {};
    this.template = {"intro": "", "body": "", "conclusion": "", "signed": ""};
  }

  set setData(DocumentSnapshot document) {
    this.template["intro"] = document["intro"];
    this.template["body"] = document["body"];
    this.template["conclusion"] = document["conclusion"];
    this.image = document["image"];
  }
}
