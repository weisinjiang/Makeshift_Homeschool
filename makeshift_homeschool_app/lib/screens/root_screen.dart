import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/bootcamp_screen.dart';
import 'package:makeshift_homeschool_app/screens/export_screens.dart';
import 'package:makeshift_homeschool_app/screens/lesson_approval.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/screens/new_video_screen.dart';
import 'package:makeshift_homeschool_app/screens/search_screen.dart';
import 'package:makeshift_homeschool_app/screens/students_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_screen.dart';
import 'package:makeshift_homeschool_app/screens/study_video_screen.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/widgets/activity_button.dart';
import 'package:makeshift_homeschool_app/widgets/ghostButton.dart';
import 'package:makeshift_homeschool_app/widgets/new_video_widgets.dart';
import 'package:provider/provider.dart';

/// Builds the main screen where the user can pick what activities they want to
/// do: Study, Teach
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  Map<String, String> userData;
  bool isEmailVerified;
  Size screenSize;

  /// Before the root screen builds, gather user data and check if their email is verified
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
    /// that when users signout, an error screen wont show

    if (userData != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
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
          // color: kPaleBlue,
          height: screenSize.height,
          width: screenSize.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// What do you want to do today? Greet image
                // Container(
                //   height: screenSize.height * 0.20,
                //   width: screenSize.width,
                //   child: Center(
                //       child: Image.asset(
                //     'asset/images/greetJoseph1.png',
                //     fit: BoxFit.contain,
                //   )),
                // ),

                // Before build, user's email was checked to be not verified
                if (!isEmailVerified)
                  Text(
                    "Please secure your account by verifying your email",
                    style: kBoldTextStyle,
                  ),

                // Render the buttons depending on if it is web or mobile because
                // Mobile app button design currently do not work on WebApp
                Builder(
                  builder: (context) {
                    if (kIsWeb) {
                      return buildWebButtons(screenSize, context);
                    } else {
                      return buildMobileButtons(screenSize, context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  currentAccountPicture: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(userData["photoURL"]),
                  ),
                  accountName: Text("${userData["username"]}"),
                  accountEmail: Text("${userData["level"]}"),
                ),
                ListTile(
                  leading: Icon(
                    Icons.fireplace,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Bootcamp",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(screen: BootCampScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Students",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(screen: StudentsPage()));
                  },
                ),
                ListTile(
                    leading: Icon(Icons.menu_book, color: Colors.white),
                    title: Text("Learn", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      showModalBottomSheet(
                          isDismissible: true,
                          backgroundColor: Colors.grey[400],
                          context: context,
                          builder: (context) {
                            return Container(
                                height: screenSize.height * 0.40,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: screenSize.height * 0.06,
                                      width: screenSize.width * 0.85,
                                      child: RaisedButton(
                                          color: Colors.transparent,
                                          child: Text(
                                            "Articles",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Pop the buttons off the screen
                                            Navigator.push(
                                                context,
                                                SlideLeftRoute(
                                                    screen: StudyScreen()));
                                          }),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      height: screenSize.height * 0.06,
                                      width: screenSize.width * 0.85,
                                      child: RaisedButton(
                                          color: Colors.transparent,
                                          child: Text(
                                            "Videos",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                SlideLeftRoute(
                                                    screen:
                                                        StudyVideoScreen()));
                                          }),
                                    )
                                  ],
                                ));
                          });
                    }),
                ListTile(
                    leading: Icon(Icons.edit, color: Colors.white),
                    title: Text("Teach", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      showModalBottomSheet(
                          isDismissible: true,
                          backgroundColor: Colors.grey[400],
                          context: context,
                          builder: (context) {
                            return Container(
                              height: screenSize.height * 0.40,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: screenSize.height * 0.06,
                                    width: screenSize.width * 0.85,
                                    child: RaisedButton(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Article Post",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Pop the buttons off the screen
                                          Navigator.push(
                                              context,
                                              SlideLeftRoute(
                                                  screen: NewPostScreen(
                                                isEditing: false,
                                                postData: null,
                                              )));
                                        }),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: screenSize.height * 0.06,
                                    width: screenSize.width * 0.85,
                                    child: RaisedButton(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Video Post",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              SlideLeftRoute(
                                                  screen: NewVideoPostScreen(
                                                isEditing: false,
                                                postData: null,
                                              )));
                                        }),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                if (userData["level"] == "Professor")
                  ListTile(
                    leading: Icon(Icons.check_box, color: Colors.white),
                    title: Text("Approve Lessons",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              screen: LessonApprovalScreen(
                            reviewer: Reviewer.principle,
                          )));
                    },
                  ),
                if (userData["level"] == "Professor" ||
                    userData["level"] == "Teacher")
                  ListTile(
                    leading: Icon(Icons.edit_attributes_outlined,
                        color: Colors.white),
                    title: Text("Review Lessons",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              screen: LessonApprovalScreen(
                            reviewer: Reviewer.teacher,
                          )));
                    },
                  )
              ],
            ),
          ),
        ),
      );
    } else {
      return LoadingScreen();
    }
  }

  Column buildMobileButtons(Size screenSize, BuildContext context) {
    return Column(
      children: [
        Text(
          "WEquil School",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Column buildWebButtons(Size screenSize, BuildContext context) {
    return Column(
      children: [
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
                    function: () => showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor: Colors.grey[400],
                        context: context,
                        builder: (context) {
                          return Container(
                            height: screenSize.height * 0.40,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.85,
                                  child: RaisedButton(
                                      color: Colors.transparent,
                                      child: Text(
                                        "Articles",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Pop the buttons off the screen
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                screen: StudyScreen()));
                                      }),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.85,
                                  child: RaisedButton(
                                      color: Colors.transparent,
                                      child: Text(
                                        "Videos",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                screen: StudyVideoScreen()));
                                      }),
                                )
                              ],
                            ),
                          );
                        }),
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
                    function: () => showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor: Colors.grey[400],
                        context: context,
                        builder: (context) {
                          return Container(
                            height: screenSize.height * 0.40,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.85,
                                  child: RaisedButton(
                                      color: Colors.transparent,
                                      child: Text(
                                        "Article Post",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Pop the buttons off the screen
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                screen: NewPostScreen(
                                              isEditing: false,
                                              postData: null,
                                            )));
                                      }),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: screenSize.height * 0.06,
                                  width: screenSize.width * 0.85,
                                  child: RaisedButton(
                                      color: Colors.transparent,
                                      child: Text(
                                        "Video Post",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            SlideLeftRoute(
                                                screen: NewVideoPostScreen(
                                              isEditing: false,
                                              postData: null,
                                            )));
                                      }),
                                )
                              ],
                            ),
                          );
                        }),
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
      ],
    );
  }
}
