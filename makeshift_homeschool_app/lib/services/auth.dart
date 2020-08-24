import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';

class AuthProvider with ChangeNotifier {
  final Firestore _database = Firestore.instance; // Connect to Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Firebase User Information
  FirebaseAuth _auth = FirebaseAuth.instance; //Status of the authentication
  String _userId;
  FirebaseUser _firebaseUser;
  bool authenticated;
  Map<String, String> _userInformation;

  // AuthProvider() {
  //   this._userId = null;
  //   this.authenticated = false;
  //   this._userInformation = null;
  //   this._firebaseUser = null;
  // }
  bool get isAuthenticated => this._firebaseUser != null;
  String get getUserID => this._userId;
  Map<String, String> get getUser => this._userInformation;

  // Get current Firebase User. Used to see if user data is still valid
  // Not async because it is used after user has logged in and exit the app
  // Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  Future<bool> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user.uid);
      this._userId = result.user.uid;
      this._firebaseUser = result.user;
      await fetchUserInfoFromDatabase()
          .then((value) => this._userInformation = value);
      notifyListeners();
      return true;
    } catch (error) {
      print(error); //! todo
      return false;
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
    this._userId = result.user.uid;
    this.authenticated = true;
    notifyListeners();

    _database.collection("users").document(result.user.uid).setData({
      // add new database for the user
      "username": userName,
      "photoURL": blankPhotoURL,
      "uid": _userId,
      "email": result.user.email,
      "level": "Student",
      "bio": "Add a bio",
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
      _userId: {
        "first name": userName,
        "referral": referral,
        "day": todaysDate.day
      }
    }, merge: true);
    await fetchUserInfoFromDatabase().then((value) => _userInformation = value);
    result.user.sendEmailVerification();
    notifyListeners();
    return true;
  }

  void signOut() {
    this.authenticated = false;
    this._userId = null;
    this._userInformation = null;
    this._firebaseUser = null;
    notifyListeners();
    //_auth.signOut();
    
    // return Future.delayed(Duration.zero);
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Connects to the users data document in Firebase. Updates if anything in it changes
  Stream<DocumentSnapshot> userDataStream() {
    return _database.collection("users").document(_userId).snapshots();
  }

  // Updates users profile image and change photoURL link
  Future<void> uploadProfileImage(File image) async {
    StorageReference storageRef = // Reference to the target storage
        _storage.ref().child("profile").child(_userId);
    StorageUploadTask uploadTask = storageRef.putFile(image); // Load image
    await uploadTask.onComplete; // Wait till complete

    //Upatde download URL
    await storageRef.getDownloadURL().then((newURL) {
      this._userInformation["photoURL"] = newURL;

      /// update url in session
      _database.collection("users").document(_userId).setData(
          {"photoURL": newURL.toString()},
          merge: true // Update the photoURL field
          );
    });

    notifyListeners();
  }

  /// Called from Edit Profile Screen
  Future<void> updateProfileInformation(
      Map<String, String> newInformation) async {
    this._userInformation["username"] = newInformation["username"];
    this._userInformation["bio"] = newInformation["bio"];
    await _database.collection("users").document(_userId).setData(
        {"username": newInformation["username"], "bio": newInformation["bio"]},
        merge: true);
    notifyListeners();
  }

  Future<Map<String, String>> fetchUserInfoFromDatabase() async {
    Map<String, String> userData = {};
    await _database
        .collection("users")
        .document(_userId)
        .get()
        .then((firestoreData) {
      userData["email"] = firestoreData["email"];
      userData["bio"] = firestoreData["bio"];
      userData["photoURL"] = firestoreData["photoURL"];
      userData["uid"] = firestoreData["uid"];
      userData["username"] = firestoreData["username"];
      userData["lesson_completed"] =
          firestoreData["lesson_completed"].toString();
      userData["lesson_created"] = firestoreData["lesson_created"].toString();
      userData["level"] = firestoreData["level"];
    });

    return userData;
  }

  Future<Map<String, String>> fetchUserInfoFromDatabaseAutoLogin(uid) async {
    Map<String, String> userData = {};
    await _database
        .collection("users")
        .document(uid)
        .get()
        .then((firestoreData) {
      userData["email"] = firestoreData["email"];
      userData["bio"] = firestoreData["bio"];
      userData["photoURL"] = firestoreData["photoURL"];
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
