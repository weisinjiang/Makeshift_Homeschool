import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/bootcamp_screen.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/lesson_approval.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/activity_button.dart';
import 'package:makeshift_homeschool_app/widgets/ghostButton.dart';
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
  bool isEmailVerified;
  Size screenSize;

  @override
  void initState() {
    userData = Provider.of<AuthProvider>(context, listen: false).getUser;
    isEmailVerified =
        Provider.of<AuthProvider>(context, listen: false).isEmailVerified;
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
            backgroundColor: kPaleBlue,
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
            color: kPaleBlue,
            height: screenSize.height,
            width: screenSize.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// What do you want to do today? Greet image
                  Container(
                    height: screenSize.height * 0.20,
                    width: screenSize.width,
                    child: Center(
                        child: Image.asset(
                      'asset/images/greetJoseph1.png',
                      fit: BoxFit.contain,
                    )),
                  ),

                  if (!isEmailVerified)
                    Text(
                      "Please secure your account by verifying your email",
                      style: kBoldTextStyle,
                    ),

                  // Render the buttons depending on if it is web or mobile
                  Builder(
                    builder: (context) {
                      if (kIsWeb) {
                        return buildWebButtons(screenSize, context);
                      } else {
                        return buildMobileButtons(screenSize, context);
                      }
                    },
                  ),

                  // only professor/principles can approve lessons
                ],
              ),
            ),
          ));
    } else {
      return LoadingScreen();
    }
  }

  Column buildMobileButtons(Size screenSize, BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: ActivityButton(
            color: kGreenPrimary,
            borderColor: Colors.green[300],
            height: screenSize.height * 0.20,
            width: screenSize.width,
            canUseButton: true,
            function: () => Navigator.push(
                context, SlideLeftRoute(screen: BootCampScreen())),
            name: "Bootcamp",
            imageLocation: "asset/images/campFire.png",
          )),
      FittedBox(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityButton(
                  color: kGreenPrimary,
                  borderColor: Colors.green[300],
                  height: screenSize.height * 0.20,
                  width: screenSize.width / 2,
                  canUseButton: true,
                  function: () => Navigator.push(
                      context, SlideLeftRoute(screen: StudyScreen())),
                  name: "Learn",
                  imageLocation: "asset/images/books.png",
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityButton(
                  color: kGreenPrimary,
                  borderColor: Colors.green[300],
                  height: screenSize.height * 0.20,
                  width: screenSize.width / 2,
                  canUseButton: true,
                  function: () => Navigator.push(
                      context, SlideLeftRoute(screen: NewPostScreen())),
                  name: "Teach",
                  imageLocation: "asset/images/teach.png",
                )),
          ])),

      if (userData["level"] == "Professor")
        Container(
          height: screenSize.height * 0.15,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GhostButton(
              borderRadius: 20.0,
              buttonBorderColor: kRedOrange,
              buttonFillColor: kRedOrange,
              buttonName: "Approve Lessons",
              buttonTextColor: Colors.black,
              function: () => Navigator.push(
                  context,
                  SlideLeftRoute(
                      screen: LessonApprovalScreen(
                    reviewer: Reviewer.principle,
                  ))),
            ),
          ),
        ),
      // show this to teachers so they can review posts or Principle
      if (userData["level"] == "Professor" || userData["level"] == "Teacher")
        Container(
          height: screenSize.height * 0.15,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GhostButton(
              borderRadius: 20.0,
              buttonBorderColor: kRedOrange,
              buttonFillColor: kRedOrange,
              buttonName: "Review Tutor Lessons",
              buttonTextColor: Colors.black,
              function: () => Navigator.push(
                  context,
                  SlideLeftRoute(
                      screen: LessonApprovalScreen(
                    reviewer: Reviewer.teacher,
                  ))),
            ),
          ),
        ),
    ]);
  }

  Column buildWebButtons(Size screenSize, BuildContext context) {
    return Column(children: [
      Container(
        height: screenSize.height * 0.15,
        width: screenSize.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GhostButton(
            borderRadius: 20.0,
            buttonBorderColor: kRedOrange,
            buttonFillColor: kRedOrange,
            buttonName: "Boot Camp",
            buttonTextColor: Colors.black,
            function: () => Navigator.push(
                context, SlideLeftRoute(screen: BootCampScreen())),
          ),
        ),
      ),
      FittedBox(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Container(
              height: screenSize.height * 0.15,
              width: screenSize.width / 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GhostButton(
                  borderRadius: 20.0,
                  buttonBorderColor: kRedOrange,
                  buttonFillColor: kRedOrange,
                  buttonName: "Learn",
                  buttonTextColor: Colors.black,
                  function: () => Navigator.push(
                      context, SlideLeftRoute(screen: StudyScreen())),
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.15,
              width: screenSize.width / 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GhostButton(
                  borderRadius: 20.0,
                  buttonBorderColor: kRedOrange,
                  buttonFillColor: kRedOrange,
                  buttonName: "Teach",
                  buttonTextColor: Colors.black,
                  function: () => Navigator.push(
                      context,
                      SlideLeftRoute(
                          screen: NewPostScreen(
                        isEditing: false,
                        postData: null,
                      ))),
                ),
              ),
            ),
          ])),
      if (userData["level"] == "Professor")
        Container(
          height: screenSize.height * 0.15,
          width: screenSize.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GhostButton(
              borderRadius: 20.0,
              buttonBorderColor: kRedOrange,
              buttonFillColor: kRedOrange,
              buttonName: "Approve Lessons",
              buttonTextColor: Colors.black,
              function: () => Navigator.push(
                  context,
                  SlideLeftRoute(
                      screen: LessonApprovalScreen(
                    reviewer: Reviewer.principle,
                  ))),
            ),
          ),
        ),
      // show this to teachers so they can review posts or Principle
      if (userData["level"] == "Professor" || userData["level"] == "Teacher")
        Container(
          height: screenSize.height * 0.15,
          width: screenSize.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GhostButton(
              borderRadius: 20.0,
              buttonBorderColor: kRedOrange,
              buttonFillColor: kRedOrange,
              buttonName: "Review Tutor Lessons",
              buttonTextColor: Colors.black,
              function: () => Navigator.push(
                  context,
                  SlideLeftRoute(
                      screen: LessonApprovalScreen(
                    reviewer: Reviewer.teacher,
                  ))),
            ),
          ),
        ),
    ]);
  }
}
