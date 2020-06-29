import 'package:flutter/material.dart';

enum AuthMode {Signup, Login} //Page will change if user is logging in or signing up

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  //Controllers that stores user input and validates passwords
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login; //Controls the page contents depending on if it is login or sign up
  String _email;  
  String _password;
  var _isLoading = false; // If async data is not recieved, this is true


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
                key: _formKey,    // key to track the forms input
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
                            borderRadius: BorderRadius.vertical()
                          ),
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter a";
                          }
                          return null;
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
                            borderRadius: BorderRadius.vertical()
                          ),
                        ),
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Enter a email address";
                          }
                          return null;
                        },
                      ),
                      ),
                  ],

                ),
              ),

            ],
          ),
        ),
        
      ),
    );


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

    }


}
