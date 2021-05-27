import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/user_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance; // Connect to Firestore
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Firebase User Information
  FirebaseAuth _auth = FirebaseAuth.instance; //Status of the authentication
  String _userId;
  bool _emailVerified;
  bool _authenticated;
  Map<String, dynamic> _userInformation;
  String _token;
  UserAuth userData;


  AuthProvider(){
    this._userId = null;
    this._emailVerified = false;
    this._authenticated = false;
    this._userInformation = null;
    this._token = null;
  }

  // Getters
  bool get isAuthenticated => this._authenticated;
  bool get isEmailVerified => this._emailVerified;
  String get getUserID => this._userId;
  Map<String, dynamic> get getUserInfo => this._userInformation;
  String get getStudentLevel => this._userInformation["level"];
  String get getStudentFirstName => this._userInformation["studentFirstName"];
  String get getStudentEmail => this._userInformation["studentEmail"];
  String get getPhotoURL => this._userInformation["photoURL"];
  String get getStudentAge => this._userInformation["studentAge"];
  int get getLessonCreated=> this._userInformation["lessonCreated"];
  int get getLessonCompleted => this._userInformation["lessonCompleted"];
  String get getToken => this._token.toString();

  // Get current Firebase User. Used to see if user data is still valid
  // Not async because it is used after user has logged in and exit the app
  // Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  Future<bool> signIn(UserAuth userInfo) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: userInfo.getStudentEmail, password: userInfo.getPassword);
      result.user.getIdToken();
      this._userId = result.user.uid;
      this._token = await result.user.getIdToken();
      this._emailVerified = result.user.emailVerified;
      await fetchAndSetUserInfoFromDatabase();
      this._authenticated = true;

      notifyListeners();

      // save a copy of the users information on their disk
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", this._userId);
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

  Future<bool> signUp(UserAuth userAuth) async {

    try {
      final blankPhotoURL = "https://firebasestorage.googleapis.com/v0/b/makeshift-homeschool-281816.appspot.com/o/profile%2FblankProfile.png?alt=media&token=a547754d-551e-4e18-a5ce-680d41bd1226";
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userAuth.getStudentEmail, password: userAuth.getPassword);

      this._userId = result.user.uid;
      print(_userId);

      _userInformation = {
        // add new database for the user
        "studentFirstName": userAuth.getStudentFirstName,
        "studentAge": userAuth.getStudentAge,
        "photoURL": blankPhotoURL,
        "uid": _userId,
        "studentEmail": result.user.email,
        "level": "Student",
        "bio": "Add a bio...",
        "accountCreatedOn": DateTime.now().toString(),
        "lessonCreated": 0,
        "lessonCompleted": 0,
        "parentInfo": {
          "firstName": userAuth.getParentFirstName,
          "lastName": userAuth.getParentLastName,
          "email": userAuth.getParentEmail,
          "phoneNumber": userAuth.getParentPhoneNumber
        }};

      // Create user
      await _database.collection("users").doc(_userId).set({
        // add new database for the user
        "studentFirstName": userAuth.getStudentFirstName,
        "studentAge": userAuth.getStudentAge,
        "photoURL": blankPhotoURL,
        "uid": _userId,
        "studentEmail": result.user.email,
        "level": "Student",
        "bio": "Add a bio...",
        "accountCreatedOn": DateTime.now().toString(),
        "lessonCreated": 0,
        "lessonCompleted": 0,
        "parentInfo": {
          "firstName": userAuth.getParentFirstName,
          "lastName": userAuth.getParentLastName,
          "email": userAuth.getParentEmail,
          "phoneNumber": userAuth.getParentPhoneNumber
        }});
      print("Data Set"); //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      // Add referral to the database
      // await _database
      //     .collection("referral") // referral database
      //     .doc("${DateTime.now().month}/${DateTime.now().year}") // Today's month + year collection
      //     .set({
      //   _userId: {
      //     "Student Name": userAuth.getStudentFirstName,
      //     "Student's Parent": "${userAuth.getParentFirstName} ${userAuth.getParentLastName}",
      //     "Referral": userAuth.getReferral,
      //     "Date": DateTime.now().toString()
      //   }
      // }, SetOptions(merge: true));
      // print("Referal Data Set"); //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


      // //! save a copy of the users information on their disk
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("userId", _userId);
      result.user.sendEmailVerification();
      this._authenticated = true;
      notifyListeners();
      return true;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userInformation")) {
      return false;
    }
    this._userId = prefs.getString("userId");
    bool success = await fetchAndSetUserInfoFromDatabase();
    if (success) {
      this._authenticated = true;
    }
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    this._authenticated = false;
    this._userId = null;
    this._userInformation = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); // dont want persisting data when users log out manually
    await _auth.signOut();

    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    // User class from firebase_auth package
    User user = _auth.currentUser;
    user.sendEmailVerification();
  }

  // Future<bool> isEmailVerified() async {
  //   FirebaseUser user = await _auth.currentUser();
  //   return user.isEmailVerified;
  // }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Connects to the users data document in Firebase. Updates if anything in it changes
  Stream<DocumentSnapshot> userDataStream() {
    return _database.collection("users").doc(_userId).snapshots();
  }

  // Updates users profile image and change photoURL link
  Future<void> uploadProfileImage(File image) async {

    // Users profile information in database
    Reference storageRef = _storage.ref().child("profile").child(_userId);
    UploadTask uploadTask = storageRef.putFile(image); // Load image
    
    await (await uploadTask).ref.getDownloadURL().then((newURL) {
      this._userInformation["photoURL"] = newURL;
      _database.collection("users").doc(_userId).set(
        {"photoURL": newURL.toString()},
        SetOptions(merge: true)
      );
    });
    notifyListeners();
  }

  /// Called from Edit Profile Screen
  Future<void> updateProfileInformation(
      Map<String, String> newInformation) async {
    this._userInformation["studentFirstName"] = newInformation["studentFirstName"];
    this._userInformation["bio"] = newInformation["bio"];
    await _database.collection("users").doc(_userId).set(
        {"username": newInformation["username"], "bio": newInformation["bio"]},
        SetOptions(merge: true));
    notifyListeners();
  }

  // UserInfo is currently in JSON form. This method sets the user data 
  // with the given firestore data
  void setUserData(DocumentSnapshot firestoreData) {

    final List<String> fields = [
      "studentFirstName",
      "studentAge",
      "photoURL",
      "uid",
      "studentEmail",
      "level",
      "bio",
      "accountCreatedOn",
      "lessonCreated",
      "lessonCompleted",
      "parentInfo"
    ];

    Map<String, dynamic> fetchedData = {};

    for (String field in fields) {
      if (field == "parentInfo") {
        // Parent info is another list of it's own
        fetchedData[field] = {
          "firstName": firestoreData[field]["firstName"],
          "lastName": firestoreData[field]["lastName"],
          "phoneNumber": firestoreData[field]["phoneNumber"]
        };
      }
      else {
        fetchedData[field] = firestoreData[field]; 
      }
    }
    this._userInformation = fetchedData;
    
  }

  // Gets the user data from the database and set them
  Future<bool> fetchAndSetUserInfoFromDatabase() async {
    try {
      await _database
          .collection("users")
          .doc(_userId)
          .get()
          .then((firestoreData) => setUserData(firestoreData));
      return true;
    }
    catch (e) {
      print("Error in FetchAndSetUserInfo: $e");
      return false;
    }
  }

  Future<Map<String, String>> fetchUserInfoFromDatabaseAutoLogin(uid) async {
    Map<String, String> userData = {};
    await _database
        .collection("users")
        .doc(uid)
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

  // Add the post id to the user's completed lessons collection and increment
  // the user's completed lesson by 1
  // Return the new lesson completed to the rating and feedback provider, so
  // that if the new rating is 5, then prompt a "Rank up.""
  Future<bool> incrementUserCompletedLessons(String postId) async {
    // users data document in Firestore
    DocumentReference userDocument =
        _database.collection("users").doc(getUserID);
    try {
      await addPostIdToCompletedCollection(postId); // add completed lesson
      // Add the post to the user's completed lessons collection
      await userDocument
          .collection("completed lessons")
          .doc(postId)
          .set({});

      // update the map data with the new lesson completed
      int lessonCompleted = this._userInformation["lessonCompleted"] + 1;
      this._userInformation["lessonCompleted"] = lessonCompleted;

      if (lessonCompleted == 5) {
        // increase lesson completed by 1 and update level
        await userDocument.update(
            {"lessonCompleted": FieldValue.increment(1), "level": "Tutor"});
        this._userInformation["level"] = "Tutor";
      } else {
        // increase lesson completed by 1
        await userDocument
            .update({"lessonCompleted": FieldValue.increment(1)});
      }
      //this._userInformation["lesson_completed"] = lessonCompleted.toString();
      notifyListeners();
      return lessonCompleted == 5;
    } catch (error) {
      throw error;
    }
  }

  Future<void> addPostIdToCompletedCollection(String postId) async {
    _database
        .collection("users")
        .doc(getUserID)
        .collection("completed lessons")
        .doc(postId)
        .set({});
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
