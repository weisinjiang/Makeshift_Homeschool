import 'package:flutter/material.dart';

enum AuthMode {
  Signup,
  Login
} //Page will change if user is logging in or signing up

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers that stores user input and validates passwords
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Signup;
  /*Controls the page contents depending on
                                         if it is login or sign up */
  String _email;
  String _password;
  var _isLoading = false; // If async data is not recieved, this is true

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
                        validator: (userEmailInput) {
                          //matched
                          if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(userEmailInput)) {
                            return null;
                          }
                          // Empty Field
                          else if (userEmailInput.isEmpty) {
                            return "Enter a email address";
                          }
                          return "Enter a valid email address";
                        },
                      ),
                    ),

                    // Password Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical()),
                        ),
                        validator: (userPasswordInput) {
                          if (userPasswordInput.isEmpty) {
                            return "Enter a password";
                          } else if (userPasswordInput.length < 8) {
                            return "Enter a password that is at least 8 characters long";
                          }
                          return null;
                        },
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
                          validator: (userPasswordInput) {
                            if (userPasswordInput.isEmpty) {
                              return "Enter a password";
                            } else if (userPasswordInput.length < 8) {
                              return "Enter a password that is at least 8 characters long";
                            }
                            return null;
                          },
                        ),
                      ),

                    RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? "Login" : "Sign up"),
                      color: Colors.green[300],
                      onPressed: () {},
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
