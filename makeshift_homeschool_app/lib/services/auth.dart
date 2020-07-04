import 'dart:async';
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

  bool get getAuthStatus => authenticated;
  FirebaseUser get getUserData => _user;

  // Get current Firebase User. Used to see if user data is still valid
  // Not async because it is used after user has logged in and exit the app
  // Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  // //Check if the user is still authenticated
  // Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  Future<bool> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      authenticated = true;
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

  Future<bool> signUp(String email, String password, String userName) async {
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
      "level": "student",
      "bio": "empty",
      "lesson_created": 0,
      "lesson_completed": 0
    });
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
    _auth.signOut();
    authenticated = false;
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
    if (_user != null) {
      return _database.collection("users").document(_user.uid).snapshots();
    }
  }
}
