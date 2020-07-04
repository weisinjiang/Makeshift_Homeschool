import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/my_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context); // auth provider
    var user = auth.getUserData;

    // StreamBuilder(
    //   stream: ,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       var user = snapshot.data;
    //       return Container(
    //         color: Colors.red,
    //         child: Column(
    //           children: <Widget>[
    //             SizedBox(
    //               height: 100,
    //             ),
    //             Center(child: Text("${user.email}")),
    //             RaisedButton(
    //               onPressed: () async {
    //                 await auth.signOut();
    //                 Navigator.of(context)
    //                     .pushNamedAndRemoveUntil('/', (route) => false);
    //               },
    //               child: Text("Signout"),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else {
    //       return LoadingScreen();
    //     }
    //   },
    // );

    if (user != null) {
      return Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(child: Text("${user.email}")),
            RaisedButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: Text("Signout"),
            ),
          ],
        ),
      );
    } else {
      return LoadingScreen();
    }
  }
}
