import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';


/// ListTile for Bootcamp.
/// Users will click before showing them the lesson details

class BootCampListTile extends StatelessWidget {
  final String title;         /// Thumbnail name for the activity
  final Function navigationFunction;  /// Navigation function

  const BootCampListTile({Key key, this.title, this.navigationFunction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
              color: kPaleBlue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2.0)),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: navigationFunction, // fire the nav function passed from Bootcamp Screen
            child: ListTile(
              leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: title == "See your Completed Bootcamps" 
                  ? FittedBox(child: Icon(Icons.email, color: Colors.black,))
                  :Image.asset(
                    'asset/bootcamp/$title.png', //! To add. Name the same as title
                    fit: BoxFit.contain,
                  )),
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: kParagraphTextStyle,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
