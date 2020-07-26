import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class CompletedLetters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Letters"),),
          body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Text("Coming Soon", style: kHeadingTextStyle,),
            LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
