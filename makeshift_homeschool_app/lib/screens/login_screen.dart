import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';
import 'package:makeshift_homeschool_app/shared/scale_transition.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../shared/constants.dart';
import '../models/user_auth_model.dart';

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

  AuthMode _authMode = AuthMode.Login; // Signup or login page

  UserAuth _userInput = UserAuth(); // Stores user info and validates it

  // Dropdown list for referal section
  Set<String> _referalList = {
    "Facebook",
    "Instagram",
    "Twitter",
    "Wequil Website",
    "Seth Peleg",
    "William Den Herder",
    "Other"
  };
  String _referalSelected = "";

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
        _referalSelected = "";
      });
    }
  }

  /// **************************************************************************
  /// Login/Signup Button Pressed Logic
  ///***************************************************************************

  Future<void> _submit(AuthProvider auth) async {
    if (!_formKey.currentState.validate()) {
      // Validation failed
      return;
    }
    _formKey.currentState.save();

    try {
      // Attempt to log user in
      if (_authMode == AuthMode.Login) {
        var result =
            await auth.signIn(_userInput.getEmail, _userInput.getPassword);

        if (result == true) {
          Navigator.pushReplacement(context, ScaleRoute(screen: RootScreen()));
        }
        else {
          _showErrorMessage("Email or Password is incorrect or does not exist");
        }

        // User Sign up
      } else {
        var result = await auth.signUp(
            _userInput.getEmail,
            _userInput.getPassword,
            _userInput.getUsername,
            _userInput.getReferral);
        if (result == true) {
          Navigator.pushReplacement(context, ScaleRoute(screen: RootScreen()));
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
        messageForUser = "Email already exist, please use a different email";
      } else if (error.contains("ERROR_INVALID_EMAIL") || error.contains("ERROR_WRONG_PASSWORD")) {
        messageForUser = "Email or Password is incorrect";
      }

      _showErrorMessage(exception.toString());
    }
  }

  /// **************************************************************************
  /// Password Confirmation
  ///***************************************************************************

  String confirmPassword(String toConfirm) {
    if (toConfirm != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
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
                  padding: const EdgeInsets.fromLTRB(0, 35, 20, 0),
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
                    // if signup, then have a username field
                    if (_authMode == AuthMode.Signup)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical()),
                          ),
                          onSaved: (userNameInput) =>
                              _userInput.setUsername = userNameInput,
                        ),
                      ),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userEmailInput) =>
                            _userInput.validateEmail(userEmailInput),
                        onSaved: (userEmailInput) =>
                            _userInput.setEmail = userEmailInput,
                      ),
                    ),

                    // Password Field
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userPasswordInput) {
                          if (_authMode == AuthMode.Signup) {
                            return _userInput
                                .validatePassword(userPasswordInput);
                          }
                          return null;
                        },
                        onSaved: (userPasswordInput) =>
                            _userInput.setPassword = userPasswordInput,
                      ),
                    ),

                    // if signing up, show confirm password and ref section
                    if (_authMode == AuthMode.Signup) ...[
                      // Confirm Password
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical()),
                          ),
                          validator: (userConfirmPasswordInput) =>
                              confirmPassword(userConfirmPasswordInput),
                        ),
                      ),

                      // Referral
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "How did you find us?",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.vertical()),
                            ),
                            items: _referalList
                                .map((listItem) => DropdownMenuItem<String>(
                                      child: Text(listItem),
                                      value: listItem,
                                    ))
                                .toList(),
                            hint: Text(_referalSelected), // shows selected ref
                            onChanged: (changedDropdownItem) {
                              // ref changed, save the value
                              setState(() {
                                _referalSelected = changedDropdownItem;
                                if (changedDropdownItem != "Other") {
                                  // Set the ref if it is not "Other"
                                  _userInput.setReferal = changedDropdownItem;
                                }
                              });
                            }),
                      ),

                      // If referral is Other, have the user give us where they found us and save it
                      if (_referalSelected == "Other")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Please tell us where",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.vertical()),
                            ),
                            validator: (userRefInput) =>
                                _userInput.validateReferral(userRefInput),
                            onSaved: (userRefInput) =>
                                _userInput.setReferal = userRefInput,
                          ),
                        ),
                    ],
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
                          )),
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
                            _submit(
                                auth); // pass auth object into the function for access
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
                          splashColor: Colors
                              .transparent, // Prevents showing button highlight
                          highlightColor: Colors.transparent,
                          child: Text(
                            _authMode == AuthMode.Login ? "Sign up" : "Login",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: kGreenSecondary),
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
