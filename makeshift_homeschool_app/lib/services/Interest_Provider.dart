import 'package:flutter/material.dart';

/*
  Handles list of interests and it is used as a manager for interests.
  InterestChip handles UI of the chip, this provider handles the logic of
  sending/fetching from Firestore  as well as tracking interests that the user
  has selected.

*/

class InterestProvider {

  List<String> interestList;
  List<String> selectedList;
  InterestProvider() {

    // Change to getting from Firestore
    interestList = ["Statistics", "Piano", "History", 
                    "Economics", "Computer Science",
                    "Chemistry", "Geometry", "Biology",
                    "Algebra", "Engineering", "Art", "Gaming",
                    "Minecraft", "Drawing"
    ];
    
    // user selected, should get user's list from Firestore. Otherwise blank
    selectedList = [];

  }

  List<String> getInterests() => this.interestList;

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