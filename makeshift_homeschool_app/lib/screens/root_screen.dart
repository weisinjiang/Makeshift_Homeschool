import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/bootcamp_screen.dart';
import 'package:makeshift_homeschool_app/screens/completed_letters.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/activity_button.dart';
import 'package:provider/provider.dart';

/// Builds the main screen where the user can pick what activities they want to
/// do: Study, Teach
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var _isInit = true;
  var _isLoading = false;
  Map<String, String> userData;
  Size screenSize;

  @override
  void initState() {
    userData = Provider.of<AuthProvider>(context, listen: false).getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    /// upon signout, userData will be set to null. This conditional is so
    /// that when users signout, an error wont be thrown

    if (userData != null) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Hi, ${userData["username"]}!"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Navigator.push(
                    context, SlideLeftRoute(screen: ProfileScreen())),
              )
            ],
          ),

          // endDrawer: AppDrawer(
          //   userData: userData,
          // ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGreenSecondary, kGreenSecondary_analogous1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            height: screenSize.height,
            width: screenSize.width,
            //color: kGreenSecondary,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// What do you want to do today? Greet image
                  Container(
                    height: screenSize.height * 0.20,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('asset/images/greet.png'),
                    ),
                  ),

                  // Boot camp
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ActivityButton(
                      color: kGreenPrimary,
                      borderColor: colorPaleSpring,
                      height: screenSize.height * 0.20,
                      width: screenSize.width,
                      function: () => Navigator.push(
                          context, SlideLeftRoute(screen: BootCampScreen())),

                      // function: () => Navigator.push(context,
                      //           SlideLeftRoute(screen: BootCampScreen())),
                      canUseButton: true,
                      name: "Boot Camp",
                      imageLocation: "asset/images/campFire.png",
                    ),
                  ),

                  /// Study and Teach Button
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Study
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityButton(
                            color: kGreenPrimary,
                            borderColor: colorPaleGreen,
                            height: screenSize.height * 0.10,
                            width: screenSize.width / 2,
                            canUseButton: true,
                            function: () => Navigator.push(
                                context, SlideLeftRoute(screen: StudyScreen())),
                            name: "Study",
                            imageLocation: "asset/images/books.png",
                          ),
                        ),

                        // Teach
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActivityButton(
                            color: kGreenPrimary,
                            borderColor: colorPalePink,
                            height: screenSize.height * 0.10,
                            width: screenSize.width / 2,
                            canUseButton: (userData["level"] == "Tutor" ||
                                    userData["level"] == "Professor")
                                ? true
                                : false,
                            function: () => Navigator.push(
                                context,
                                SlideLeftRoute(
                                    screen: NewPostScreen(
                                  isEditing: false,
                                  postData: null,
                                ))),
                            name: "Teach",
                            imageLocation: "asset/images/teach.png",
                          ),
                        ),
                      ],
                    ),
                  ),

                  //const SizedBox(height: 40,),

                  // Saved letters
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ActivityButton(
                      color: kGreenSecondary,
                      borderColor: Colors.white,
                      height: screenSize.height * 0.10,
                      width: screenSize.width,
                      function: () => Navigator.push(
                          context, SlideLeftRoute(screen: CompletedLetters())),
                      canUseButton: true,
                      name: "My Lessons",
                      imageLocation: "asset/images/letter.png",
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
