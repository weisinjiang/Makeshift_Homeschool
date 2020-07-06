import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/http_exception.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../shared/constants.dart';

//Page will change if user is logging in or signing up
enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers that stores user input and validates passwords
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  String _email;
  String _password;
  String _userName;
  var _isLoading = false; // If async data is not recieved, this is true

  void _showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (contx) => AlertDialog(
              title: Center(child: Text("ERROR")),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(contx).pop();
                  },
                )
              ],
            ));
  }

  // Method switchs between login and signup mode
  void _switchAuthMode() {
    _formKey.currentState.reset();
    _passwordController.clear();
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  /// **************************************************************************
  /// Login/Signup Button Pressed Logic
  ///***************************************************************************

  Future<void> _submit(AuthProvider auth) async {
    String result;

    if (!_formKey.currentState.validate()) {
      // Validation failed
      return;
    }
    _formKey.currentState.save();

    try {
      // Attempt to log user in
      if (_authMode == AuthMode.Login) {
        var result = await auth.signIn(_email, _password);

        if (result == true) {
          Navigator.pushReplacementNamed(context, '/root');
        }
      } else {
        var result = await auth.signUp(_email, _password, _userName);
        if (result == true) {
          Navigator.pushReplacementNamed(context, '/root');
        }
      }
      _formKey.currentState.reset(); // Clear the form when logged in
      _passwordController.clear();
    } catch (exception) {
      // if errors occur during login
      var messageForUser =
          "Error occured, please try again"; // message to tell the user
      String error = exception.toString();

      // User does not exists in the database
      if (error.contains("ERROR_USER_NOT_FOUND")) {
        messageForUser = "Account does not exists";
      } else if (error.contains("ERROR_EMAIL_ALREADY_IN_USE")) {
        messageForUser = "Email already exist";
      }

      _showErrorMessage(exception.toString());
    }
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
  final regExValidPassword = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  /* 
    Validates the password the user enters
    @param  : password the user inputs into the Form TextField
    @return :  true or false
  */
  String validatePassword(String userInput) {
    if (regExValidPassword.hasMatch(userInput)) {
      return null;
    } else if (userInput.length < 8) {
      return "Password needs to be at least 8 characters long";
    }
    return "Password must have at least 1 number, special character, upper and lower case letter";
  }

  String confirmPassword(String toConfirm) {
    if (toConfirm != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
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

  /// **************************************************************************
  /// Build UI Method                                                          *
  ///***************************************************************************
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      //Initial container that fills the entire screen
      body: Container(
        color: Colors.white,
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // About Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: RaisedButton(
                    color: kGreenPrimary,
                    onPressed: () => Navigator.of(context).pushNamed('/about'),
                    child: Text("About"),
                  ),
                ),
              ),

              //Logo
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset('asset/images/logo.png'),
              ),

              Form(
                key: _formKey, // key to track the forms input
                child: Column(
                  children: <Widget>[
                    if (_authMode == AuthMode.Signup)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical()),
                          ),
                          onSaved: (userNameInput) => _userName = userNameInput,
                        ),
                      ),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userEmailInput) =>
                            validateEmail(userEmailInput),
                        onSaved: (userEmailInput) => _email = userEmailInput,
                      ),
                    ),

                    // Password Field
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userPasswordInput) =>
                            validatePassword(userPasswordInput),
                        onSaved: (userPasswordInput) =>
                            _password = userPasswordInput,
                      ),
                    ),

                    // Second password field to confirm if AuthMode == Signup
                    if (_authMode == AuthMode.Signup)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical()),
                          ),
                          validator: (userConfirmPasswordInput) =>
                              confirmPassword(userConfirmPasswordInput),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {}, //! To do
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: kGreenSecondary),
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: ButtonTheme(
                        minWidth: deviceSize.width * 0.90,
                        height: deviceSize.height * 0.07,
                        child: RaisedButton(
                          child: Text(_authMode == AuthMode.Login
                              ? "Login"
                              : "Sign up"),
                          color: kGreenPrimary,
                          onPressed: () async {
                            _submit(auth); // pass auth object into the function for access
                          },
                        ),
                      ),
                    ),

                    // Switch between Auth modes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _authMode == AuthMode.Login
                              ? "Don't have an account?"
                              : "Have an account?",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        FlatButton(
                          splashColor: Colors.transparent, // Prevents showing button highlight
                          highlightColor: Colors.transparent,
                          child: Text(
                            _authMode == AuthMode.Login ? "Sign up" : "Login",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: kGreenSecondary
                                ),
                          ),
                          onPressed: _switchAuthMode,
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
