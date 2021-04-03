import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/RandomColorGen.dart';

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

  InterestProvider() {

    // Change to getting from Firestore
    this.interestList = ["Statistics", "Piano", "History", 
                    "Economics", "Computer Science",
                    "Chemistry", "Geometry", "Biology",
                    "Algebra", "Engineering", "Art", "Gaming",
                    "Minecraft", "Drawing"
    ];
    
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

  // Use for testing to see if the list updated
  void printTest() {
    selectedList.forEach((i) {
      print(i);
    });
    print("--------");
  }

  
}