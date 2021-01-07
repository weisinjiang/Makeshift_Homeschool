import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/edit_profile_screen.dart';
import 'package:makeshift_homeschool_app/screens/user_post.dart';
import 'package:makeshift_homeschool_app/widgets/user_profile_appbar.dart';
import 'package:makeshift_homeschool_app/widgets/widgets.dart';
import '../shared/constants.dart';
import '../shared/exportShared.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

double getLevelAsPercentage(String level) {
  if (level == "Student") {
    return 0.25;
  } else if (level == "Tutor") {
    return 0.50;
  } else if (level == "Teacher") {
    return 0.75;
  }
  return 1.0;
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenSize = MediaQuery.of(context).size;

    /// Consumer of Authprovider because this entire widget depends on
    /// the user data that AuthProvider has. When an update is changed, Auth
    /// Provider will notify the widget to rebuild
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      if (auth.getUser != null) {
        /// if auth provider has user data
        return Scaffold(
            appBar: UserProfileAppBar(
              screenSize: screenSize,
              appBar: AppBar(
                //backgroundColor: Colors.white,
              ),
            ),
            body: Container(
              //color: Colors.white,
              // Main box for the entire profile screen
              height: screenHeight,
              width: screenWidth,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       colors: [kGreenSecondary, kGreenSecondary_shade1],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter),
              // ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.asset(
                              "asset/images/profile_screen_picture.png"),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      // Avatar
                                      Flexible(
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              auth.getUser["photoURL"]),
                                          backgroundColor: Colors.greenAccent,
                                          // child: Text("${userData["username"][0]}"),
                                        ),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${auth.getUser["username"]}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                    width: screenWidth,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Flexible(
                                              child: ListTile(
                                            title: Text(
                                              auth.getUser["lesson_created"],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "Lessons\nCreated",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Flexible(
                                              child: ListTile(
                                            title: Text(
                                              auth.getUser["lesson_completed"],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "Lessons\nCompleted",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                        ])),
                              ],
                            ),
                          )
                        ],
                      ),

                      // Contains: Avatar, Name, Level, Bio
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          //height: screenHeight * 0.30, // top 30% of the screen
                          width: screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // Avatar
                              // Flexible(
                              //   child: CircleAvatar(
                              //     radius: 50,
                              //     backgroundImage:
                              //         NetworkImage(auth.getUser["photoURL"]),
                              //     backgroundColor: Colors.greenAccent,
                              //     // child: Text("${userData["username"][0]}"),
                              //   ),
                              // ),
                              // Flexible(
                              //     child: ListTile(
                              //   title: Text(
                              //     auth.getUser["lesson_created"],
                              //     style: kBoldTextStyle,
                              //   ),
                              //   subtitle: Text("Lessons\nCreated"),
                              // )),

                              // Flexible(
                              //     child: ListTile(
                              //   title: Text(
                              //     auth.getUser["lesson_completed"],
                              //     style: kBoldTextStyle,
                              //   ),
                              //   subtitle: Text("Lessons\nCompleted"),
                              // )),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "${auth.getUser["username"]}",
                      //     style: kTitleTextStyle,
                      //     textAlign: TextAlign.start,
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          "Level",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: screenWidth,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: LinearProgressIndicator(
                                  minHeight: 30.0,
                                  value: getLevelAsPercentage(
                                      auth.getUser["level"]),
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kGreenPrimary),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  auth.getUser["level"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )),

                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: screenHeight * 0.10,
                        width: screenWidth * 0.95,
                        child: Text(
                          "${auth.getUser["bio"]}",
                          textAlign: TextAlign.start,
                          style: simpleTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      } else {
        return LoadingScreen();
      }
    });

    // return Container(
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         height: screenHeight * 0.30,
    //         width: screenWidth,
    //         child: Row(
    //           children: <Widget>[
    //             Flexible(
    //               child: Padding(
    //                   padding: const EdgeInsets.all(20.0),
    //                   child: CircleAvatar(
    //                     radius: 50,
    //                     // backgroundImage: NetworkImage(user.photoUrl),
    //                     backgroundColor: Colors.green,
    //                   )),
    //             ),
    //             Flexible(
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     vertical: 40.0, horizontal: 5),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: <Widget>[
    //                     Text("Wei Jiang", style: kTitleTextStyle, textAlign: TextAlign.center,),
    //                     Text("Tutor Level", style: kTitleTextStyle, textAlign: TextAlign.center,),
    //                     Text("Bio")
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Divider(thickness: 3,),
    //     ],
    //   ),
    // );
  }
}

// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 80);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height - 80);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
