import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/screens/edit_profile_screen.dart';
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
    var userData = Provider.of<AuthProvider>(context).getUser;
    print(userData["photoURL"]);

    if (userData != null) {
      // Get user data from stream
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            elevation: 0,
          ),
          body: Container(
            // Main box for the entire profile screen
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [kGreenSecondary, kGreenSecondary_shade1],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter),
            // ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Contains: Avatar, Name, Level, Bio
                  Container(
                    //height: screenHeight * 0.30, // top 30% of the screen
                    width: screenWidth,
                    child: Row(
                      children: <Widget>[
                        // Avatar
                        Flexible(
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(userData["photoURL"]), 
                                backgroundColor: Colors.greenAccent,
                                // child: Text("${userData["username"][0]}"),
                              )),
                        ),

                        // Username, Level and Bio
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40.0, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "${userData["username"]}",
                                  style: kTitleTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${userData["level"]}",
                                  style: kTitleTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 2.0)),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                      value: getLevelAsPercentage(
                                          userData["level"]),
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kGreenPrimary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.10,
                    width: screenWidth * 0.90,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38)),
                    child: Text(
                      "${userData["bio"]}",
                      textAlign: TextAlign.center,
                      style: kParagraphTextStyle,
                    ),
                  ),

                  RaisedButton(
                    color: Colors.red[200],
                    child: Text("Sign out"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed("/login");
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                    },
                  ),

                  ///Edit Profile Button
                  RaisedButton(
                    child: Text("Edit Profile"),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                  currentData: userData,
                                ))),
                  ),

                  Divider(
                    thickness: 3,
                  ),
                ],
              ),
            ),
          ));
    } else {
      return LoadingScreen();
    }

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
