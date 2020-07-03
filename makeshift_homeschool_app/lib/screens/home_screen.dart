import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/shared/my_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user =  Provider.of<FirebaseUser>(context);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightGreen[300],
      //   title: Text("Makeshift Homeschool"),

      // ),
      // bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(child: Text(user.displayName)),
            RaisedButton(
              onPressed: () async {
             
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
                await auth.signOut();
              },
              child: Text("Signout"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              child: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
