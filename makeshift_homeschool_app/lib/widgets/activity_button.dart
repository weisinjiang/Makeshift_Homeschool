import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';

class ActivityButton extends StatelessWidget {
  final Color color;
  final String name;
  final double height;
  final double width;
  final Function function;
  final String imageLocation;
  final bool
      canUseButton; // if user is not a certain level, they cant use the button

  const ActivityButton(
      {Key key,
      this.color,
      this.name,
      this.function,
      this.height,
      this.width,
      this.imageLocation,
      this.canUseButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      color: Colors.transparent,
      child: Ink(
        // For adding a black border
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 6)),
        child: InkWell(
          onTap: canUseButton
              ? function
              : () {
                  // show a snack bar if user has no permission
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("You cannot use this, yet"),
                    duration: Duration(seconds: 2),
                  ));
                }, // Function this button will perform
          child: Container(
            //color: Colors.transparent,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      imageLocation,
                    ),
                    colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.7), BlendMode.dstATop),
                    fit: BoxFit.fill)),
            height: height,
            width: width,
            child: Row(
              // Name of the button next to a icon
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width / 1.4, //fills half of the entire box
                  child: FittedBox(
                    // Prevents the text from leaving the box due to expanded
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: StrokeText(
                        text: name,
                        fontSize: 60,
                        strokeColor: Colors.white,
                        strokeWidth: 5,
                        textColor: Colors.black,
                      ),
                      // child: Text(name,
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       fontSize: 50,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     )),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     width: width / 2, // fills the second half of the box
                //     child: Padding(
                //       padding: const EdgeInsets.all(13.0),
                //       child: Image.asset(
                //         imageLocation,
                //         alignment: Alignment.center,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
