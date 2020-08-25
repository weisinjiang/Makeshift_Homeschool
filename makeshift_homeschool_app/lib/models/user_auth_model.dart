/// Stores information for when users signup or login

class UserAuth {
  Map<String, String> _userInput;

  UserAuth() {
    this._userInput = {
      "username": null,
      "email": null,
      "password": null,
      "referral": null
    };
  }

  /// Getters to get the info in the map
  String get getUsername => this._userInput["username"];
  String get getEmail => this._userInput["email"];
  String get getPassword => this._userInput["password"];
  String get getReferral => this._userInput["referral"];

  ///Setters to set information
  set setUsername(username) => this._userInput["username"] = username;
  set setEmail(String email) => this._userInput["email"] = email;
  set setPassword(String password) => this._userInput["password"] = password;
  set setReferal(String ref) => this._userInput["referral"] = ref;

  String validateReferral(String ref) {
    if (ref == "") {
      return "Please tell us how you found us";
    }
    return null;
  }

  /// **************************************************************************
  /// Password Validation
  ///***************************************************************************

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

  /// **************************************************************************
  /// Email Validation                                                         *
  ///***************************************************************************

  /* 
    Regular Expression that makes sure email is in the valid format
  */
  final regExValidEmail = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /* 
    Validates the password the user enters
    @param  : password the user inputs into the Form TextField
    @return :  true or false
  */
  String validateEmail(String userInput) {
    if (regExValidEmail.hasMatch(userInput)) {
      return null;
    }
    return "Invalid Email";
  }
}
