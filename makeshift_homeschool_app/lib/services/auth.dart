import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // Firebase Instance
  final Firestore _database = Firestore.instance; // Connect to Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current Firebase User
  Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  /*
    Method chnages the UI based on authentication state. 
      User signs in, out and user change
  */
  Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<dynamic> getImage(String photoURL) async {
    return await _storage
        .ref()
        .child("profile")
        .child("blankProfile.png")
        .getDownloadURL();
  }

  Future<String> signUp(String email, String password, String userName) async {
    // Sign the user up
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user; // variable containing user's info
    UserUpdateInfo updateInfo = UserUpdateInfo(); // used to update user's info
    updateInfo.displayName = userName;
    updateInfo.photoUrl =
        "gs://makeshift-homeschool-281816.appspot.com/profile/blankProfile.png";
    user.updateProfile(updateInfo);
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> getCurrentUserName() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.displayName.toString();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
