import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/my_bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var user = auth.getUserData;

    return StreamBuilder(
      stream: auth.userDataStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          DocumentSnapshot userData = snapshot.data;
          return Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userData["photoURL"]),
                            backgroundColor: Colors.transparent,
                          )),
                      Text("${userData["username"]}")
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        } else {
          return LoadingScreen();
        }
      },
    );

    // return Container(
    //     child: Column(
    //       children: <Widget>[
    //         Row(
    //           children: <Widget>[
    //             Padding(
    //                 padding: const EdgeInsets.all(20.0),
    //                 child: CircleAvatar(
    //                   radius: 50,
    //                   // backgroundImage: NetworkImage(user.photoUrl),
    //                   backgroundColor: Colors.transparent,
    //                 )),
    //             Text("${user.uid}")
    //           ],
    //         ),
    //         Divider(),
    //         Divider()
    //       ],
    //     ),

    // );
  }
}
