import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/main_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/new_post_provider.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'shared/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build of main.dart");
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            // auth service
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<NewPostProvider>(
            // Tracks user paragraphs and subtitles
            create: (context) => NewPostProvider(),
          ),
          ChangeNotifierProvider<PostFeedProvider>(
            // reteieves user posts in Study
            create: (context) => PostFeedProvider([]),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, _) => MaterialApp(
            theme: ThemeData(
                primaryColor: kGreenSecondary,
                textTheme:
                    GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
            home:
                //PostThumbnail(),
                auth.isAuthenticated ? MainScreen() : LoginScreen(),
            // routes: {
            //   '/login': (context) => LoginScreen(), // Root Screen
            //   //'/root': (context) => RootScreen(),
            //   '/main': (context) => MainScreen(),
            //   '/about': (context) => AboutScreen(),
            //   '/home': (context) => HomeScreen(),
            //   //'/profile': (context) => ProfileScreen(),
            // },
          ),
        ));
  }
}
