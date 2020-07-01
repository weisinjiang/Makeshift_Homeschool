import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/homeScreen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: AuthProvider().user) // Provides user auth
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => LoginScreen(), // Root Screen
          '/home': (context) => HomeScreen()
        },
      ),
    );
  }
}
