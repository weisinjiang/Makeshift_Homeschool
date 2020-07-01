import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(child: Text(user.email)),
      ),
    );
  }
}
