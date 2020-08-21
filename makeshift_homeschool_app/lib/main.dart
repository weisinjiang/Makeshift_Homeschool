import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            // auth service
            create: (context) => AuthProvider(),
          ),

          ChangeNotifierProxyProvider<AuthProvider, PostFeedProvider>(
            // reteieves user posts in Study
            update: (context, auth, previousPosts) => PostFeedProvider(
              auth.getUserID,
              previousPosts == null ? [] : previousPosts.getPosts
            ), create: (_) => PostFeedProvider(null, []),
          ),
          ChangeNotifierProxyProvider<AuthProvider,BootCampProvider>(
            create: (_) => BootCampProvider(null, []),
            update: (context, auth, previousLessons) => BootCampProvider(
              auth.getUserID,
              previousLessons == null ? [] : previousLessons.getUserLessons

            )
          )
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, _) => MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.black,
                textTheme:
                    GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
            home: auth.isAuthenticated ? RootScreen() : LoginScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
              '/root': (context) => RootScreen(),
              '/about': (context) => AboutScreen(),
              '/study': (context) => StudyScreen(),
              '/profile': (context) => ProfileScreen(),
            },
          ),
        ));
  }
}
