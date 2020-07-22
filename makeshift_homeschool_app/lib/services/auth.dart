import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // Connect to Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Firebase User Information
  FirebaseAuth _auth = FirebaseAuth.instance; //Status of the authentication
  FirebaseUser _user; // User information

  bool authenticated = false;
  Map<String, String> _userInformation;

  bool get isAuthenticated => authenticated;
  FirebaseUser get getUserData => _user;
  String get getUserID => _user.uid;
  Map<String, String> get getUser => _userInformation;

  // Get current Firebase User. Used to see if user data is still valid
  // Not async because it is used after user has logged in and exit the app
  // Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  Future<bool> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      authenticated = true;
      await getUserInformation().then((value) => _userInformation = value);
      notifyListeners();
      return true;
    } catch (error) {
      return false;
      print(error); //! todo
    }
  }

  // Get users image based on UID
  Future<dynamic> getImageURL(String uid) async {
    return await _storage.ref().child("profile").child(uid).getDownloadURL();
  }

  // Datetime Switch Method to get the name of the month int
  String getMonthNameFromInt(int monthNum) {
    switch (monthNum) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
    }
    return "No case match";
  }

  Future<bool> signUp(
      String email, String password, String userName, String referral) async {
    var blankPhotoURL =
        "https://firebasestorage.googleapis.com/v0/b/makeshift-homeschool-281816.appspot.com/o/profile%2FblankProfile.png?alt=media&token=a547754d-551e-4e18-a5ce-680d41bd1226";
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    authenticated = true;

    _database.collection("users").document(result.user.uid).setData({
      // add new database for the user
      "username": userName,
      "photoURL": blankPhotoURL,
      "uid": _user.uid,
      "email": _user.email,
      "level": "Student",
      "bio": " ",
      "lesson_created": 0,
      "lesson_completed": 0
    });
    var todaysDate = DateTime.now(); // today's date
    var todaysMonth = DateTime.now().month;
    var monthYear =
        getMonthNameFromInt(todaysMonth) + " " + todaysDate.year.toString();

    // Add referral to the database
    _database
        .collection("referral") // referral database
        .document(monthYear) // Today's month + year collection
        .setData({
      _user.uid: {
        "first name": userName,
        "referral": referral,
        "day": todaysDate.day
      }
    }, merge: true);
    notifyListeners();
    return true;
  }

  // Future<FirebaseUser> getCurrentUser() async {
  //   FirebaseUser user = await _firebaseAuth.currentUser();
  //   await user.reload();
  //   return user;
  // }

  // Future<String> get getCurrentUserName async {
  //   FirebaseUser user = await _firebaseAuth.currentUser();
  //   return user.displayName.toString();
  // }

  Future<void> signOut() async {
    await _auth.signOut();
    authenticated = false;
    _userInformation =
    _user = null;
    notifyListeners();
    // return Future.delayed(Duration.zero);
  }

  // Future<void> sendEmailVerification() async {
  //   FirebaseUser user = await _firebaseAuth.currentUser();
  //   user.sendEmailVerification();
  // }

  // Future<bool> isEmailVerified() async {
  //   FirebaseUser user = await _firebaseAuth.currentUser();
  //   return user.isEmailVerified;
  // }

  // Connects to the users data document in Firebase. Updates if anything in it changes
  Stream<DocumentSnapshot> userDataStream() {
    return _database.collection("users").document(_user.uid).snapshots();
  }

  // Updates users profile image and change photoURL link
  Future<void> uploadProfileImage(File image) async {
    StorageReference storageRef = // Reference to the target storage
        _storage.ref().child("profile").child(_user.uid);
    StorageUploadTask uploadTask = storageRef.putFile(image); // Load image
    await uploadTask.onComplete; // Wait till complete

    //Upatde download URL
    storageRef.getDownloadURL().then((newURL) {
      _database.collection("users").document(_user.uid).setData(
          {"photoURL": newURL.toString()},
          merge: true // Update the photoURL field
          );
    });
  }

  Future<void> updateProfileInformation(
      Map<String, String> newInformation) async {
    await _database.collection("users").document(_user.uid).setData(
        {"username": newInformation["username"], "bio": newInformation["bio"]},
        merge: true);
  }

  Future<Map<String, String>> getUserInformation() async {
    Map<String, String> userData = {};
    await _database
        .collection("users")
        .document(_user.uid)
        .get()
        .then((firestoreData) {
      userData["email"] = firestoreData["email"];
      userData["uid"] = firestoreData["uid"];
      userData["username"] = firestoreData["username"];
      userData["lesson_completed"] =
          firestoreData["lesson_completed"].toString();
      userData["lesson_created"] = firestoreData["lesson_created"].toString();
      userData["level"] = firestoreData["level"];
    });

    return userData;
  }

  // Future<dynamic> userDataFuture() async {
  //   if (_user != null) {
  //     await _database
  //         .collection("users")
  //         .document(_user.uid)
  //         .get()
  //         .then((retrievedData) {
  //       _userInfo = User(
  //           email: retrievedData["email"],
  //           lesson_completed: retrievedData["lesson_completed"],
  //           lesson_created: retrievedData["lesson_created"],
  //           level: retrievedData["level"],
  //           photoURL: retrievedData["photoURL"],
  //           uid: retrievedData["uid"],
  //           username: retrievedData["lesson_completed"]);
  //     });
  //   }
  // }
}
