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
  final AuthProvider auth = AuthProvider(); // User data from AuthProvider

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    return FutureBuilder(
      future: auth.getImage("Fix this later"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
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
                          backgroundImage: NetworkImage(snapshot.data),
                          backgroundColor: Colors.transparent,
                        )
                      ),
                      Text("${user.displayName}")
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return LoadingScreen();
      },
    );
  }
}
