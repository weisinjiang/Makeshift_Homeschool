import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class ActivityButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String name;
  final double height;
  final double width;
  final Function function;
  final String imageLocation;
  final bool canUseButton; // students cant use teach button

  const ActivityButton(
      {Key key,
      this.color,
      this.name,
      this.function,
      this.height,
      this.width,
      this.imageLocation,
      this.canUseButton,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      color: Colors.grey,
      child: Ink(
        // For adding a black border
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 6),
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                    image: AssetImage(
                      imageLocation,
                    ),
                    colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.fill)
            ),
        child: InkWell(
          onTap: canUseButton
              ? function
              : () {
                  // show a snack bar if user has no permission
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Complete five lessons to unlock lesson builder!"),
                    duration: Duration(seconds: 2),
                  ));
                }, // Function this button will perform
          child: Container(
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
                    child: BorderedText(
                      strokeWidth: 2.0,
                      strokeColor: Colors.white,
                      child: Text(
                        name,
                        
                      )
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
