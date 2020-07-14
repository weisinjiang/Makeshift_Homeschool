import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';

class ActivityButton extends StatelessWidget {
  final Color color;
  final String name;
  final double height;
  final double width;
  final Function function;
  final String imageLocation;
  final bool canUseButton; // if user is not a certain level, they cant use the button

  const ActivityButton(
      {Key key,
      this.color,
      this.name,
      this.function,
      this.height,
      this.width,
      this.imageLocation, this.canUseButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      color: color,
      child: Ink(
        // For adding a black border
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: InkWell(
          onTap: canUseButton ? function : null, // Function this button will perform
          child: Container(
            color: Colors.transparent,
            height: height,
            width: width,
            child: Row(
              // Name of the button next to a icon
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  // makes sure these 2 widgets fit in parent container
                  child: Container(
                    width: width / 2, //fills half of the entire box
                    child: FittedBox(
                      // Prevents the text from leaving the box due to expanded
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width / 2, // fills the second half of the box
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(
                        imageLocation,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
