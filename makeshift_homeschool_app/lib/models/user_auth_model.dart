import 'package:flutter/material.dart';

/// Stores information for when users signup or login

class UserAuth {
  String studentFirstName;
  String parentFirstName;
  String parentLastName;
  String studentEmail;
  String parentEmail;
  String parentPhoneNumber;
  int studentAge;
  String password;
  String referral;
  // String photoURL;
  // String bio;
  // String accountCreatedOn;
  // String level;
  // String uid;
  List<String> interestedTopics;


  /* 
    Regular Expression that makes sure the password is:
      1. Min 8 char
      2. At least 1 upper case char
      3. At least 1 lower case char
      4. At least 1 special char
  */
  final regExValidPassword =
      RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$");

  final regExHasUppercase = RegExp(r"([A-Z])");

  /// RegEx for valid email
  final regExValidEmail = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");


  // All values will be null by default, so nothing needs to be done in the constructor
  UserAuth() {
    this.password = null;
  }



  /// Getters to get the info in the map
  String get getStudentFirstName => this.studentFirstName;
  String get getParentFirstName => this.parentFirstName;
  String get getParentLastName => this.parentLastName;
  String get getStudentEmail => this.studentEmail;
  String get getParentEmail => this.parentEmail;
  String get getParentPhoneNumber => this.parentPhoneNumber;
  int get getStudentAge => this.studentAge;
  String get getPassword => this.password;
  String get getReferral => this.referral;




  ///Setters to set information
  set setStudentFirstName(String firstName) => this.studentFirstName = firstName;
  set setStudentAge(String age) => this.studentAge = int.parse(age);
  set setParentFirstName(String parentName) => this.parentFirstName = parentName;
  set setParentLastName(String lastName) => this.parentLastName = lastName;
  set setParentPhoneNumber(String number) => this.parentPhoneNumber = number;
  set setStudentEmail(String email) => this.studentEmail = email;
  set setParentEmail(String email) => this.parentEmail = email;
  set setPassword(String password) => this.password = password;
  set setReferral(String ref) => this.referral = ref;


  /// Valudates age for user to be at least 13
  String validateAge(String age) {

    if (int.parse(age) < 13) {
      return "You cannot use this app because you are under 13.";
    }
    return null;

  }

  /// Make sure name is not empty
  String validateName(String name) {
    if (name.isEmpty) {
      return "1 or more name field is empty";
    }
    return null;
  }

  /// Validates that user entered a referral
  String validateReferral(String ref) {
    if (ref == "") {
      return "Please tell us how you found us";
    }
    return null;
  }


  /* 
    Validates the password the user enters
    @param  : password the user inputs into the Form TextField
    @return :  true or false
  */
  String validatePassword(String userInput) {
    if (regExValidPassword.hasMatch(userInput)) {
      return null;
    } else if (userInput.length < 8) {
      return "Not at least 8 characters long";
    } else if (!regExHasUppercase.hasMatch(userInput)) {
      return "Missing uppercase letter";
    } else {
      return "Include at least 1 number, special character";
    }
  }

  /* 
    Validates the password the user enters
    @param  : password the user inputs into the Form TextField
    @return :  true or false
  */
  String validateEmail(String userInput, bool isStudent) {
    if (!regExValidEmail.hasMatch(userInput)) {
      return isStudent ? "Student Email Invalid": "Parent Email Invalid";
    }
    return null;
  }

  

  
}
