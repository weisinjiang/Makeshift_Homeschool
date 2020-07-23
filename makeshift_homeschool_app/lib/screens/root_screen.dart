import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/activity_button.dart';
import 'package:makeshift_homeschool_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

/// Builds the main screen where the user can pick what activities they want to
/// do: Study, Teach
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  Stream<QuerySnapshot> collectionStream;
  Map<String, String> userData;
  var _isInThisWidget = true; // makes sure getting the providers only execute once
  var _isLoadingPostThumbnails = false; // loading the lessons 

  @override
  void initState() {
    //userDataStream = Provider.of<AuthProvider>(context).userDataStream();
    //print("UserDataStreamCalled");
    super.initState();
  }

  ///!
  @override
  void didChangeDependencies() {
    print("Inside didCHANGE");
    if (_isInThisWidget) {
      setState(() {
        print("Setting loading t true");
        _isLoadingPostThumbnails = true;
      });
      print("Getting collection stream");
      collectionStream =
          Provider.of<PostFeedProvider>(context).lessonsCollectionStream();
      print("Getting user data");
      userData = Provider.of<AuthProvider>(context).getUser;
      print("Setting isin to false");
      _isInThisWidget = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILDING");
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    /// upon signout, userData will be set to null. This conditional is so
    /// that when users signout, an error wont be thrown
    if (userData != null) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Hi, ${userData["username"]}!"),
          ),
          endDrawer: AppDrawer(
            userData: userData,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGreenSecondary, kGreenSecondary_analogous1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: screenHeight,
            width: screenWidth,
            //color: kGreenSecondary,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// What do you want to do today? Greet image
                  Container(
                    height: screenHeight * 0.25,
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('asset/images/greet.png'),
                    ),
                  ),

                  // Boot camp
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ActivityButton(
                      color: kGreenSecondary_analogous2,
                      height: screenHeight * 0.20,
                      width: screenWidth,
                      function: () {},
                      canUseButton: true,
                      name: "Boot Camp",
                      imageLocation: "asset/images/campFire.png",
                    ),
                  ),

                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Study
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityButton(
                            color: kGreenSecondary_analogous2_shade,
                            height: screenHeight * 0.10,
                            width: screenWidth / 2,
                            canUseButton: true,
                            function: () => Navigator.push(
                                context,
                                SlideLeftRoute(
                                    screen: StudyScreen(
                                  collectionStream: collectionStream,
                                ))),
                            name: "Study",
                            imageLocation: "asset/images/books.png",
                          ),
                        ),

                        // Teach
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityButton(
                            color: kGreenSecondary_analogous2_shade,
                            height: screenHeight * 0.10,
                            width: screenWidth / 2,
                            canUseButton: (userData["level"] == "Tutor" ||
                                    userData["level"] == "Professor")
                                ? true
                                : false,
                            function: () => Navigator.push(context,
                                SlideLeftRoute(screen: NewPostScreen())),
                            name: "Teach",
                            imageLocation: "asset/images/teach.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return LoadingScreen();
    }
  }
}
