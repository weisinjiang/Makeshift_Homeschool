import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/warning_messages.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailInputController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    var auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Builder(
        builder: (context) => Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width * 0.70,
                child: TextField(
                  controller: emailInputController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.10,
              ),
              RaisedButton(
                  child: Text("Reset Password"),
                  color: kGreenPrimary,
                  onPressed: () {
                    auth.resetPassword(emailInputController.text);
                    emailInputController.clear();
                    Scaffold.of(context).showSnackBar(
                        snackBarMessage("Email send, please check your email"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
