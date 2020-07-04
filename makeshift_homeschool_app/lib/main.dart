import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/home_screen.dart';
import 'package:makeshift_homeschool_app/screens/profile_screen.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';
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
        ChangeNotifierProvider.value(
            value: AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) =>
        MaterialApp(
          
          home: auth.getAuthStatus == false ? LoginScreen() : RootScreen(),
        routes: {
          '/login': (context) => LoginScreen(), // Root Screen
          '/root': (context) => RootScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen()
        },
      ),
    )
    );
  }
}
