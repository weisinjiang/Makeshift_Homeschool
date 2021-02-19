import 'package:flutter/material.dart';
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
              appBar: AppBar(),
            ),
            body: Container(
              // Main box for the entire profile screen
              height: screenHeight,
              width: screenWidth,
              color: Colors.black,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.black,
                            width: screenSize.width,
                            height: 150,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      NetworkImage(auth.getUser["photoURL"]),
                                  backgroundColor: Colors.greenAccent,
                                  // child: Text("${userData["username"][0]}"),
                                ),
                              SizedBox(height: 20,),
                                Text(
                          "${auth.getUser["username"]}",
                          style: titleTextStyle(),
                          textAlign: TextAlign.start,
                        ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Contains: Avatar, Name, Level, Bio
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          //height: screenHeight * 0.30, // top 30% of the screen
                          width: screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // Avatar
                              // Flexible(
                              //   child:
                              // ),

                              // Flexible(
                              //     child: ),

                      //         Flexible(
                      //             child: ListTile(
                      //           title: Text(
                      //             "",
                      //             style: simpleTextStyle(),
                      //           ),
                      //           subtitle: Text(
                      //             "Lessons\nCompleted",
                      //             style: simpleTextStyle(),
                      //           ),
                      //         )),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          Text("Lessons Created", style: mediumTextStyle(),),
                          Text(
                            auth.getUser["lesson_created"],
                            style: simpleTextStyle(),
                          ),
                        ],
                      )),

                      Padding(
                        padding: EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.,
                        children: [
                          Text("Lessons Completed", style: mediumTextStyle(),),
                          Text(
                            auth.getUser["lesson_completed"],
                            style: simpleTextStyle(),
                          ),
                        ],
                      )),
                          SizedBox(height: 10,),
                        Text("Bio", style: mediumTextStyle(),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: screenWidth * 0.95,
                        child: Text(
                          "${auth.getUser["bio"]}",
                          textAlign: TextAlign.start,
                          style: simpleTextStyle(),
                        ),
                      ),
                                            SizedBox(
                        height: 15,
                      ),
                      
                        Text("Level", style: mediumTextStyle(),),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                                  style: simpleTextStyle(),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
                    ]))))
        );
      } else {
        return LoadingScreen();
      }
    });
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
