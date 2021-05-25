import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/RandomColorGen.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';

/*
  Handles list of interests and it is used as a manager for interests.
  InterestChip handles UI of the chip, this provider handles the logic of
  sending/fetching from Firestore  as well as tracking interests that the user
  has selected.

*/

class InterestProvider with ChangeNotifier{

  List<String> interestList;
  List<String> selectedList;
  Map<String, Color> chipColorMapping;
  RandomColorGen randomColorGen;
  Interest interestType;
  String uid;

  final FirebaseFirestore _database = FirebaseFirestore.instance;


  InterestProvider(Interest type, String userId) {

    this.interestType = type;
    this.uid = userId;
    // Change to getting from Firestore
    this.interestList = [];

    // user selected, should get user's list from Firestore. Otherwise blank
    this.selectedList = [];
    this.randomColorGen = new RandomColorGen();
    this.chipColorMapping = new Map();
    initializeInterestList();

  }

  List<String> get getInterests => this.interestList;
  Map<String, Color> get getChipColorMap => this.chipColorMapping;

  void updateSelectedList(List<String> updateList) {
    selectedList = updateList;
   
  }

  bool selectedAtLeastOne() {
    if (selectedList.isEmpty) {
      return false;
    }
    return true;
  }

  // Saves the user selected interest into their profile
  Future<void> save() async {
    
    await _database.collection("users").doc(uid).set({
      "classroomInterest": selectedList
    }, SetOptions(merge: true));

  }

  // Based on what type of interest the user
  Future<void> initializeInterestList() async {
    print("Initialize Interest List Ran");
    if (interestType == Interest.CLASSROOMS) {
      try {
        // Add demo day topics to the 
        DocumentSnapshot classroomList = await _database.collection("Classrooms").doc("classroom list").get();
        
        List<dynamic> dynamicList = (classroomList["list"] as List).toList();
        this.interestList = List<String>.from(dynamicList);
        notifyListeners();
      } catch (e) {
        print("Error in Initialize Interest List in interest_provider.dart");
        print("Error: $e");
      }
    }

    this.interestList.forEach((chip) {
      Color randomColor = this.randomColorGen.generateRandomColor();
      this.chipColorMapping[chip] = randomColor;

    });

  }

  // Use for testing to see if the list updated
  void printTest() {
    selectedList.forEach((i) {
      print(i);
    });
    print("--------");
  }

  
}