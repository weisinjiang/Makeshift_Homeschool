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

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var userData = Provider.of<AuthProvider>(context).getUser;

    // Get user data from stream
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          // Main box for the entire profile screen
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kGreenSecondary, kGreenSecondary_shade1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            children: <Widget>[
              // Contains: Avatar, Name, Level, Bio
              Container(
                height: screenHeight * 0.30, // top 30% of the screen
                width: screenWidth,
                child: Row(
                  children: <Widget>[
                    // Avatar
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 50,
                            // backgroundImage:
                            //     NetworkImage(userData["photoURL"]), add later
                            backgroundColor: Colors.greenAccent,
                            child: Text("${userData["username"][0]}"),
                          )),
                    ),

                    // Username, Level and Bio
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              "Level: ${userData["level"]}",
                              style: kTitleTextStyle,
                              textAlign: TextAlign.start,
                            ),
                            // Text(
                            //   "${userData["bio"]}",
                            //   textAlign: TextAlign.start,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              RaisedButton(
                color: Colors.redAccent,
                child: Text("Sign out"),
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                  await Provider.of<AuthProvider>(context, listen: false).signOut();
                },
              ),

              // // Edit Profile Button
              // RaisedButton(
              //   child: Text("Edit Profile"),
              //   onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => EditProfileScreen(
              //                 currentData: userData,
              //               ))),
              // ),

              Divider(
                thickness: 3,
              ),
            ],
          ),
        ));

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
