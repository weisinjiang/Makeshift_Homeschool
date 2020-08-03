import 'package:flutter/material.dart';

/// File contains widgets that shows messages on the screen for the user as a pop up


/// Snackbar to show at the bottom of the app when users do what they cant do
SnackBar snackBarMessage(String message) {
  return SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  );
}

void showErrorMessage(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (contx) => AlertDialog(
              title: Center(child: Text("ERROR")),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(contx).pop();
                  },
                )
              ],
            ));
  }


void showConfirmIsParentDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (contx) => AlertDialog(
              title: Center(child: Text("LEGAL")),
              content: Text("By clicking continue you are confirming that you are a parent signing up your child for Makeshift Homeschool"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Continue"),
                  onPressed: () {
                    Navigator.of(contx).pop();
                  },
                )
              ],
            ));
  }