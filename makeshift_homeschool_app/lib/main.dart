import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeshift_homeschool_app/screens/DemoDayScreen.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/root_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/bootcamp_provider.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/services/student_page_provider.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'shared/constants.dart';
import 'package:firebase_core/firebase_core.dart'; // Initialize FirebaseApp


/// Main file where Flutter runs the app
/// Goes through initialization of Firebase first then it runs the app.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // First initialize Firebase before entering the app
    return FutureBuilder(

      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(home: LoadingScreen()); //! FUTURE: add error message to the loading screen
        }
        
        else if (snapshot.connectionState == ConnectionState.done) {
          return startApp();
        }
        return MaterialApp(home: LoadingScreen());
      },
      
    );
  }

  // Entry to the app
  MultiProvider startApp() {
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
            previousPosts == null ? [] : previousPosts.getPosts),
        create: (_) => PostFeedProvider(null, []),
      ),

      // //^ Add ChangeNotfierProxyProvider for Auth, Studentprovider using the
          // //^ the same format as above
          // ChangeNotifierProxyProvider<AuthProvider, StudentsPageProvider>(
          //   // reteieves user posts in Study
          //   update: (context, auth, studentList) => StudentsPageProvider(
          //       auth.getUserID,
          //       studentList),
          //   create: (_) => StudentsPageProvider(),
          // ),


      ChangeNotifierProxyProvider<AuthProvider, VideoFeedProvider> (  
        update: (context, auth, prevVideoPosts) => VideoFeedProvider(  
          uid: auth.getUserID,
          allVideoPosts: prevVideoPosts == null ? []: prevVideoPosts.getVideoPosts
        ),
        create: (_) => VideoFeedProvider(uid: null, allVideoPosts: []),
      ),


      ChangeNotifierProxyProvider<AuthProvider, BootCampProvider>(
          create: (_) => BootCampProvider(null, []),
          update: (context, auth, previousLessons) => BootCampProvider(
              auth.getUserID,
              previousLessons == null ? [] : previousLessons.getUserLessons))
    ],
    child: Consumer<AuthProvider>(
      builder: (context, auth, _) =>
        MaterialApp(
          theme: ThemeData(
              primaryColor: kGreenSecondary,
              textTheme:
                  GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
          home: auth.isAuthenticated ? RootScreen() : LoginScreen(),
          debugShowCheckedModeBanner: false,
          //home: InterestPickerScreen(interestType: Interest.DEMODAYTOPICS,),
                  
          routes: {
            '/login': (context) => LoginScreen(),
            '/root': (context) => RootScreen(),
            '/about': (context) => AboutScreen(),
            '/study': (context) => StudyScreen(),
            '/profile': (context) => ProfileScreen(),
            '/demoday': (context) => DemoDayScreen()
          },
         
      
      )));
  }
}
