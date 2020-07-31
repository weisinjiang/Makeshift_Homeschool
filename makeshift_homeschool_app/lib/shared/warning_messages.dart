import 'package:flutter/material.dart';

/// File contains widgets that shows messages on the screen for the user as a pop up


/// Snackbar to show at the bottom of the app when users do what they cant do
SnackBar snackBarMessage(String message) {
  return SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  );
}

void _showErrorMessage(String message, BuildContext context) {
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