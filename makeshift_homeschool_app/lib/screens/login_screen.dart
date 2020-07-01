import 'package:flutter/material.dart';
import '../services/auth.dart';

//Page will change if user is logging in or signing up
enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider auth = AuthProvider();     //Functions for signIn, etc.

  //Controllers that stores user input and validates passwords
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  String _email;
  String _password;
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
  /// Login/Signup Button Pressed Logic                                        *
  ///***************************************************************************

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_email);
    print(_password);

    if (_authMode == AuthMode.Login) {
      await auth.signIn(_email, _password);
    } else {
      await auth.signUp(_email, _password);
    }
  }

  /// **************************************************************************
  /// Password Validation                                                      *
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

    return Scaffold(
      //Initial container that fills the entire screen
      body: Container(
        color: Colors.white,
        width: deviceSize.width,
        height: deviceSize.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Logo
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('asset/images/logo.png'),
              ),

              Form(
                key: _formKey, // key to track the forms input
                child: Column(
                  children: <Widget>[
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userPasswordInput) =>
                            validatePassword(userPasswordInput),
                        onSaved: (userPasswordInput) => _password = userPasswordInput,
                      ),
                    ),

                    // Second password field to confirm if AuthMode == Signup
                    if (_authMode == AuthMode.Signup)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.vertical()),
                          ),
                          validator: (userConfirmPasswordInput) =>
                              confirmPassword(userConfirmPasswordInput),
                        ),
                      ),

                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? "Login" : "Sign up"),
                      color: Colors.green[300],
                      onPressed: _submit,
                    ),

                    // Switch between Auth modes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(_authMode == AuthMode.Login
                            ? "Dont have an account?"
                            : "Have an account?"),
                        FlatButton(
                          child: Text(_authMode == AuthMode.Login
                              ? "Sign up"
                              : "Login"),
                          onPressed: _switchAuthMode,
                        )
                      ],
                    )
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
