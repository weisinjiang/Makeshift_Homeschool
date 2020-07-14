import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/home_screen.dart';
import 'package:makeshift_homeschool_app/screens/main_screen.dart';
import 'package:makeshift_homeschool_app/screens/profile_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'shared/constants.dart';
import 'screens/edit_profile_screen.dart';


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
          theme: ThemeData(  
            primaryColor: kGreenSecondary,
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
          ),
          home: auth.getAuthStatus == false ? LoginScreen() : MainScreen(),
          routes: {
            '/login': (context) => LoginScreen(), // Root Screen
            //'/root': (context) => RootScreen(),
            '/main': (context) => MainScreen(),
            '/about': (context) => AboutScreen(),
            '/home': (context) => HomeScreen(),
            //'/profile': (context) => ProfileScreen(),
          },
      ),
    )
    );
  }
}
