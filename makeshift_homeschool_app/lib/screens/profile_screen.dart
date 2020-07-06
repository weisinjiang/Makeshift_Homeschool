import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/exportShared.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:image_picker/image_picker.dart'; // load images

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var auth = Provider.of<AuthProvider>(context);
    var user = auth.getUserData;

    //Uplaod Image Variables
    File _imageFile;
    String _imageURL;

    // Pick an image by source: Gallery or Camera
    Future<void> _chooseNewProfilePicture(ImageSource source) async {
      ImagePicker imagePicker = ImagePicker();
      final pickedImage = await imagePicker.getImage(
          source: source, maxHeight: 180, maxWidth: 180);
      setState(() {
        _imageFile = File(pickedImage.path);
      });
      auth.uploadProfileImage(_imageFile);
    }

    //Remove Image
    void _clearNewProfilePictureSelection() {
      setState(() {
        _imageFile = null;
      });
    }

    void _buildImagePickerPopUpMenu(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext contx) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text("Choose from Library"),
                    onTap: () {
                      _chooseNewProfilePicture(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    return StreamBuilder(
      stream: auth.userDataStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          DocumentSnapshot userData = snapshot.data;
          return Scaffold(
              body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: screenHeight * 0.30,
                  width: screenWidth,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userData["photoURL"]),
                              backgroundColor: Colors.green,
                            )),
                      ),
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
                              Text(
                                "${userData["level"]}",
                                style: kTitleTextStyle,
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "Bio",
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text("Edit Profile Picture"),
                  onPressed: () => _buildImagePickerPopUpMenu(context),
                ),
                Divider(
                  thickness: 3,
                ),
              ],
            ),
          ));
        } else {
          return LoadingScreen();
        }
      },
    );

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
