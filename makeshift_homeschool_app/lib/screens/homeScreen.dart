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
    //FirebaseUser user = Provider.of<FirebaseUser>(context);

    return FutureBuilder(
      future: auth.getCurrentUserName(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            bottomNavigationBar: MyBottomNavigationBar(),
            body: Container(
              color: Colors.red,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Center(child: Text(snapshot.data)),
                  RaisedButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
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
       return LoadingScreen(); // If data is not loaded
        
      },
    );
  }
}
