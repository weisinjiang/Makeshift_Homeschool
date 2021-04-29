import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeshift_homeschool_app/promo/firstsignup.dart';
import 'package:makeshift_homeschool_app/screens/InterestPickerScreen.dart';
import 'package:makeshift_homeschool_app/screens/reset_password.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';
import 'package:makeshift_homeschool_app/shared/scale_transition.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth.dart';
import '../shared/constants.dart';
import '../models/user_auth_model.dart';
/// Builds the Login Screen
/// Enum Authmode determines which Firebase method to use: login or signup
/// It will also determine how the screen will look.

//Page will change if user is logging in or signing up
enum AuthMode { Signup, Login }

// Creates the LoginScreen State and re
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers that stores user input and validates passwords
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  // Initial page will be a login page
  AuthMode _authMode = AuthMode.Login;

  // Dropdown list for referal section during signup
  //! TODO: Make this a singleton because login wont need this extra data
  Set<String> _referalList = {
    "Facebook",
    "Instagram",
    "LinkedIn",
    "Twitter",
    "Wequil Website",
    "Seth Peleg",
    "William Den Herder",
    "Other"
  };
  // User selected referral will be saved
  String _referalSelected = "";

  // Method to show an error message
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

  // Method switchs between login and signup screens
  void _switchAuthMode() {
    _formKey.currentState.reset();
    _passwordController.clear();
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      showAlertDialog(
          "By clicking continue you are confirming that you are a parent signing up your child for Makeshift Homeschool and you will not use your child's real name during sign up",
          "LEGAL",
          context);
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

  Future<void> _submit(AuthProvider auth, UserAuth _userInput) async {
    if (!_formKey.currentState.validate()) {
      // Validation failed
      return;
    }
    // Validation success
    _formKey.currentState.save();
   
    try {
      // Attempt to log user in
      if (_authMode == AuthMode.Login) {
        var isSignedIn = await auth.signIn(_userInput); 

        // If successful, Main.dart will swap to RootScreen
        //var isSignedIn = await auth.signIn("roxas600@gmail.com", "Checkmate1@");
        if (!isSignedIn) {
          _showErrorMessage("Email or Password is incorrect or does not exist");
        }

        // User Sign up
      } else {
        var result = await auth.signUp(_userInput);
        if (result == true) {
          Navigator.pushReplacement(context, ScaleRoute(screen: RootScreen()));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => IntroSlides()));
          // // this is where you add the code
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
      } else if (error.contains("ERROR_INVALID_EMAIL") ||
          error.contains("ERROR_WRONG_PASSWORD")) {
        messageForUser = "Email or Password is incorrect";
      }
      //_formKey.currentState.reset();
      _passwordController.clear();
      _showErrorMessage(messageForUser.toString());
    }
  }

  _launchURL(context) async {
    const privacyUrl =
        "https://firebasestorage.googleapis.com/v0/b/makeshift-homeschool-281816.appspot.com/o/PRIVACY%20NOTICE.pdf?alt=media&token=35bbadd4-5e47-42d7-b9c5-bee4daa2f0ce";
    if (await canLaunch(privacyUrl)) {
      await launch(privacyUrl);
    } else {
      showErrorMessage("Unable to make the connection to host", context);
    }
  }

  _launchURL2(context) async {
    const termsofuseUrl =
        "https://firebasestorage.googleapis.com/v0/b/makeshift-homeschool-281816.appspot.com/o/END%20USER%20LICENSE%20AGREEMENT.pdf?alt=media&token=0dc52b43-2e35-4c33-9001-ef7de7ca3a1f";
    if (await canLaunch(termsofuseUrl)) {
      await launch(termsofuseUrl);
    } else {
      showErrorMessage("Unable to make the connection to host", context);
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
    final screenSize = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context, listen: false);
    UserAuth _userInput = new UserAuth();

    return Scaffold(
      //Initial container that fills the entire screen
      body: Container(
        color: Colors.white,
        width: screenSize.width,
        height: screenSize.height,
        alignment: Alignment.center,
        // Smaller container that goes inside the inital container that fills the entire screen
        child: Container(
          color: Colors.white,
          height: screenSize.height * 0.95,
          width: screenSize.width,
          // Scrollable to prevent pixle overflow
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[

                  // About Button on the top right
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 20, 0),
                      child: RaisedButton(
                        color: kGreenPrimary,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/about'),
                        child: const Text("About"),
                      ),
                    ),
                  ),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image.asset('asset/images/logo.png'),
                  ),

                  // Builder will return differnt widgets depending on if it is 
                  // mobile or web
                  Builder(
                    builder: (context) {
                      // if (kIsWeb) {
                      //   return buildWebForm(
                      //       screenSize, _userInput, context, auth);
                      // } else {
                        return buildMobileForm( _userInput,
                            context, screenSize, auth);
                      //}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/// The mobile widget of the loginscreen
/// Builds the textfields, buttons and widgetst that switches between
/// Authmodes.
/// 
/// @param passed into this method
/// @ _userInput - this is an object containing information the user inputted
/// @ context - the current widget tree's location
/// @ screenSize 
/// @ auth - auth object to call signin or signout
  Column buildMobileForm(UserAuth _userInput, BuildContext context, Size screenSize, AuthProvider auth) {

    // Only letters and max of 15 char for name fields
    List<TextInputFormatter> nameFormatter = [LengthLimitingTextInputFormatter(15), FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))];

    return Column(
      children: [
        Form(
          key: _formKey, // key to track the forms input
          child: Column(
            children: <Widget>[
              
              // Student first name
              if (_authMode == AuthMode.Signup) ... [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: nameFormatter,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Your First name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    onSaved: (userNameInput) => _userInput.setStudentFirstName = userNameInput,
                    validator: (userInput) => _userInput.validateName(userInput),
                  ),
                ),

                // How old are you?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Your Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    onSaved: (age) => _userInput.setStudentAge = age,
                    validator: (age) => _userInput.validateAge(age),
                  ),
                ),

                // Parent First name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: nameFormatter,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Parent First name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    onSaved: (userNameInput) => _userInput.setParentFirstName = userNameInput,
                    validator: (userNameInput) => _userInput.validateName(userNameInput),
                  ),
                ),

                /// Parent Last Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: nameFormatter,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Parent Last Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    onSaved: (userNameInput) => _userInput.setParentLastName = userNameInput,
                    validator: (userNameInput) => _userInput.validateName(userNameInput),
                  ),
                ),

              // Parent Email Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Parent Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical()),
                  ),
                  validator: (userEmailInput) => _userInput.validateEmail(userEmailInput, false),
                  onSaved: (userEmailInput) => _userInput.setParentEmail = userEmailInput,
                ),
              ),

              // Parent Phone Number
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Parent Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    onSaved: (number) => _userInput.setParentPhoneNumber = number,
                  ),
                ),
              ],

              // Email Field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical()),
                  ),
                  validator: (userEmailInput) => _userInput.validateEmail(userEmailInput, true),
                  onSaved: (userEmailInput) => _userInput.setStudentEmail = userEmailInput,
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
                    hintText: "Password*",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical()),
                  ),
                  validator: (userPasswordInput) {
                    if (_authMode == AuthMode.Signup) {
                      return _userInput.validatePassword(userPasswordInput);
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
                      hintText: "Confirm Password*",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                    validator: (userConfirmPasswordInput) =>
                        confirmPassword(userConfirmPasswordInput),
                  ),
                ),

                // Password Requirements Explanation
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(
                          "*Password must be 8 or more characters with at least one each number, symbol, lowercase & uppercase letter used.",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),

                // Pick Interested DemoDay Topics
                InterestPickerScreen(),

                // Referral
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownButtonFormField<String>(
                //       decoration: InputDecoration(
                //         prefixIcon: Icon(Icons.search),
                //         hintText: "How did you find us?",
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.vertical()),
                //       ),
                //       items: _referalList
                //           .map((listItem) => DropdownMenuItem<String>(
                //                 child: Text(listItem),
                //                 value: listItem,
                //               ))
                //           .toList(),
                //       hint: Text(_referalSelected), // shows selected ref
                //       onChanged: (changedDropdownItem) {
                //         // ref changed, save the value
                //         setState(() {
                //           _referalSelected = changedDropdownItem;
                //           if (changedDropdownItem != "Other") {
                //             // Set the ref if it is not "Other"
                //             _userInput.setReferral = changedDropdownItem;
                //           }
                //         });
                //       }),
                // ),

              //   // If referral is Other, have the user give us where they found us and save it
              //   if (_referalSelected == "Other")
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           hintText: "Please tell us where",
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.vertical()),
              //         ),
              //         validator: (userRefInput) =>
              //             _userInput.validateReferral(userRefInput),
              //         onSaved: (userRefInput) =>
              //             _userInput.setReferral = userRefInput,
              //       ),
              //     ),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).push(ScaleRoute(screen: ResetPasswordScreen()));
                    },
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
                  minWidth: screenSize.width * 0.90,
                  height: screenSize.height * 0.07,
                  child: RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? "Login" : "Sign up"),
                    color: kGreenPrimary,
                    onPressed: () async {
                      _submit(auth, _userInput);
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
                    splashColor:
                        Colors.transparent, // Prevents showing button highlight
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
              SizedBox(
                height: 30,
              ),

              /// Term & Conditions, Privacy Policy
              Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  Text(
                    "By signing up or logging in, you agree to our ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color: kGreenSecondary, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _launchURL(context);
                    },
                  ),
                  Text(
                    " and ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    child: Text(
                      "Terms Of Use",
                      style: TextStyle(
                          color: kGreenSecondary, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _launchURL2(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

/// The WEB widget of the loginscreen
/// Builds the textfields, buttons and widgetst that switches between
/// Authmodes.
/// 
/// @param passed into this method
/// @ _userInput - this is an object containing information the user inputted
/// @ context - the current widget tree's location
/// @ screenSize 
/// @ auth - auth object to call signin or signout
  // Column buildWebForm(Size screenSize, UserAuth _userInput,
  //     BuildContext context, AuthProvider auth) {
  //   return Column(
  //     children: [
  //       Form(
  //         key: _formKey, // key to track the forms input
  //         child: Container(
  //           // Screen larger than
  //           width: screenSize.width >= 500
  //               ? screenSize.width * 0.40
  //               : screenSize.width,
  //           child: Column(
  //             children: <Widget>[
  //               // if signup, then have a username field
  //               if (_authMode == AuthMode.Signup)
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: TextFormField(
  //                     maxLength: 300,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.person),
  //                       hintText: "Username",
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.vertical()),
  //                     ),
  //                     onSaved: (userNameInput) =>
  //                         _userInput.setUsername = userNameInput,
  //                   ),
  //                 ),

  //               // Email Field
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: TextFormField(
  //                   keyboardType: TextInputType.emailAddress,
  //                   decoration: const InputDecoration(
  //                     prefixIcon: Icon(Icons.email),
  //                     hintText: "Email",
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.vertical()),
  //                   ),
  //                   validator: (userEmailInput) =>
  //                       _userInput.validateEmail(userEmailInput),
  //                   onSaved: (userEmailInput) =>
  //                       _userInput.setEmail = userEmailInput,
  //                 ),
  //               ),

  //               // Password Field
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
  //                 child: TextFormField(
  //                   obscureText: true,
  //                   controller: _passwordController,
  //                   decoration: InputDecoration(
  //                     prefixIcon: Icon(Icons.lock),
  //                     hintText: "Password",
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.vertical()),
  //                   ),
  //                   validator: (userPasswordInput) {
  //                     if (_authMode == AuthMode.Signup) {
  //                       return _userInput.validatePassword(userPasswordInput);
  //                     }
  //                     return null;
  //                   },
  //                   onSaved: (userPasswordInput) =>
  //                       _userInput.setPassword = userPasswordInput,
  //                 ),
  //               ),

  //               // if signing up, show confirm password and ref section
  //               if (_authMode == AuthMode.Signup) ...[
  //                 // Confirm Password
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: TextFormField(
  //                     obscureText: true,
  //                     decoration: InputDecoration(
  //                       prefixIcon: Icon(Icons.lock_outline),
  //                       hintText: "Confirm Password",
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.vertical()),
  //                     ),
  //                     validator: (userConfirmPasswordInput) =>
  //                         confirmPassword(userConfirmPasswordInput),
  //                   ),
  //                 ),

  //                 // Referral
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: DropdownButtonFormField<String>(
  //                       decoration: InputDecoration(
  //                         prefixIcon: Icon(Icons.search),
  //                         hintText: "How did you find us?",
  //                         border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.vertical()),
  //                       ),
  //                       items: _referalList
  //                           .map((listItem) => DropdownMenuItem<String>(
  //                                 child: Text(listItem),
  //                                 value: listItem,
  //                               ))
  //                           .toList(),
  //                       hint: Text(_referalSelected), // shows selected ref
  //                       onChanged: (changedDropdownItem) {
  //                         // ref changed, save the value
  //                         setState(() {
  //                           _referalSelected = changedDropdownItem;
  //                           if (changedDropdownItem != "Other") {
  //                             // Set the ref if it is not "Other"
  //                             _userInput.setReferal = changedDropdownItem;
  //                           }
  //                         });
  //                       }),
  //                 ),

  //                 // If referral is Other, have the user give us where they found us and save it
  //                 if (_referalSelected == "Other")
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: TextFormField(
  //                       decoration: InputDecoration(
  //                         hintText: "Please tell us where",
  //                         border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.vertical()),
  //                       ),
  //                       validator: (userRefInput) =>
  //                           _userInput.validateReferral(userRefInput),
  //                       onSaved: (userRefInput) =>
  //                           _userInput.setReferal = userRefInput,
  //                     ),
  //                   ),
  //               ],
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: FlatButton(
  //                     splashColor: Colors.transparent,
  //                     highlightColor: Colors.transparent,
  //                     onPressed: () {
  //                       Navigator.of(context)
  //                           .push(ScaleRoute(screen: ResetPasswordScreen()));
  //                     },
  //                     child: const Text(
  //                       "Reset Password",
  //                       style: TextStyle(
  //                           fontStyle: FontStyle.italic,
  //                           fontWeight: FontWeight.bold,
  //                           color: kGreenSecondary),
  //                     )),
  //               ),

  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
  //                 child: ButtonTheme(
  //                   minWidth: screenSize.width * 0.90,
  //                   height: screenSize.height * 0.07,
  //                   child: RaisedButton(
  //                     child: Text(
  //                         _authMode == AuthMode.Login ? "Login" : "Sign up"),
  //                     color: kGreenPrimary,
  //                     onPressed: () async {
  //                       _submit(auth, _userInput);
  //                     },
  //                   ),
  //                 ),
  //               ),

  //               // Switch between Auth modes
  //               Wrap(
  //                 direction: Axis.vertical,
  //                 crossAxisAlignment: WrapCrossAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     _authMode == AuthMode.Login
  //                         ? "Don't have an account?"
  //                         : "Have an account?",
  //                     style: TextStyle(
  //                       fontStyle: FontStyle.italic,
  //                     ),
  //                   ),
  //                   FlatButton(
  //                     splashColor: Colors
  //                         .transparent, // Prevents showing button highlight
  //                     highlightColor: Colors.transparent,
  //                     child: Text(
  //                       _authMode == AuthMode.Login ? "Sign up" : "Login",
  //                       style: TextStyle(
  //                           fontStyle: FontStyle.italic,
  //                           fontWeight: FontWeight.bold,
  //                           color: kGreenSecondary),
  //                     ),
  //                     onPressed: _switchAuthMode,
  //                   )
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 30,
  //               ),

  //               /// Term & Conditions, Privacy Policy
  //               Wrap(
  //                 direction: Axis.horizontal,
  //                 children: <Widget>[
  //                   Text(
  //                     "By signing up or logging in, you agree to our ",
  //                     style: TextStyle(color: Colors.grey),
  //                   ),
  //                   InkWell(
  //                     child: Text(
  //                       "Privacy Policy",
  //                       style: TextStyle(
  //                           color: kGreenSecondary,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     onTap: () {
  //                       _launchURL(context);
  //                     },
  //                   ),
  //                   Text(
  //                     " and ",
  //                     style: TextStyle(color: Colors.grey),
  //                   ),
  //                   InkWell(
  //                     child: Text(
  //                       "Terms Of Use",
  //                       style: TextStyle(
  //                           color: kGreenSecondary,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     onTap: () {
  //                       _launchURL2(context);
  //                     },
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
