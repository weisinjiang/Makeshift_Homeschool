import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
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
import 'package:provider/provider.dart';

/// Builds the main screen where the user can pick what activities they want to
/// do: Study, Teach
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Stream<DocumentSnapshot> userDataStream;
  Stream<QuerySnapshot> collectionStream;
  var _isInThisWidget = true;
  var _isLoadingPostThumbnails = false;

  @override
  void initState() {
    //userDataStream = Provider.of<AuthProvider>(context).userDataStream();
    //print("UserDataStreamCalled");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("Inside didCHANGE");
    if (_isInThisWidget) {
      print("Getting user data stream");
      userDataStream = Provider.of<AuthProvider>(context).userDataStream();
      print("Getting collection stream");
      collectionStream =
          Provider.of<PostFeedProvider>(context).lessonsCollectionStream();
    }
    print("Setting isin to false");
    _isInThisWidget = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILDING");
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.hasError) {
          var userData = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                //title: Text("Hi, Testing!"),
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                      // User profile
                      icon: Icon(Icons.person_outline),
                      onPressed: () => Navigator.push(
                          context, SlideLeftRoute(screen: ProfileScreen())))
                ],

                title: Text("Hi, ${userData["username"]}!"),
              ),
              body: !_isLoadingPostThumbnails
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              kGreenSecondary,
                              kGreenSecondary_analogous1
                            ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      function: () => Navigator.push(context,
                                          SlideLeftRoute(screen: StudyPage(collectionStream: collectionStream,))),
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
                                      canUseButton: (userData["level"] ==
                                                  "Tutor" ||
                                              userData["level"] == "Professor")
                                          ? true
                                          : false,
                                      function: () => Navigator.push(
                                          context,
                                          SlideLeftRoute(
                                              screen: NewPostScreen())),
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
                    )
                  : LoadingScreen());
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
