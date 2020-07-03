import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // Firebase Instance
  final Firestore _database = Firestore.instance; // Connect to Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current Firebase User. Used to see if user data is still valid
  // Not async because it is used after user has logged in and exit the app
  Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  //Check if the user is still authenticated
  Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  // Get users image based on UID
  Future<dynamic> getImage(String uid) async {
    return await _storage.ref().child("profile").child(uid).getDownloadURL();
  }

  Future<String> signUp(String email, String password, String userName) async {
    // Sign the user up
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user; // variable containing user's info
    UserUpdateInfo updateInfo = UserUpdateInfo(); // used to update user's info
    updateInfo.displayName = userName; // update the username
    updateInfo.photoUrl =
        await getImage("blankProfile.png"); // default profile pic
    await user.updateProfile(updateInfo); // update the profile
    _database.collection("users").document(user.uid).setData({
      // add new database for the user
      "level": "student",
      "bio": "empty",
      "lesson_created": 0,
      "lesson_completed": 0
    });

    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> get getCurrentUserName async {
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
