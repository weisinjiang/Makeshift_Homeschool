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

class InterestProvider {

  List<String> interestList;
  List<String> selectedList;
  Map<String, Color> chipColorMapping;
  RandomColorGen randomColorGen;
  Interest interestType;

  final FirebaseFirestore _database = FirebaseFirestore.instance;


  InterestProvider(Interest type) {

    this.interestType = type;
    // Change to getting from Firestore
    this.interestList = [];

    // user selected, should get user's list from Firestore. Otherwise blank
    this.selectedList = [];
    this.randomColorGen = new RandomColorGen();
    this.chipColorMapping = new Map();
    

    this.interestList.forEach((chip) {
      Color randomColor = this.randomColorGen.generateRandomColor();
      this.chipColorMapping[chip] = randomColor;

    });

  }

  List<String> get getInterests => this.interestList;
  Map<String, Color> get getChipColorMap => this.chipColorMapping;

  void updateSelectedList(List<String> updateList) {
    selectedList = updateList;
   
  }

  // Based on what type of interest the user
  Future<void> initializeInterestList() async {

    if (interestType == Interest.DEMODAYTOPICS) {
      try {
        // Add demo day topics to the 
        DocumentSnapshot demoTopics = await _database.collection("DemoDay").doc("Topics").get();
        this.interestList = demoTopics["topics"];
        
      } catch (e) {
        print("Error in Initialize Interest List in interest_provider.dart");
        print("Error: $e");
      }
    }

  }

  // Use for testing to see if the list updated
  void printTest() {
    selectedList.forEach((i) {
      print(i);
    });
    print("--------");
  }

  
}