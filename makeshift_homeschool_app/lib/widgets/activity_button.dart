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

  const ActivityButton(
      {Key key, this.color, this.name, this.function, this.height, this.width,this.imageLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      color: kGreenSecondary_analogous2,

      child: Ink(
        // decoration: BoxDecoration(  
        //           gradient: LinearGradient(
        //             colors: [kGreenSecondary_analogous2, kGreenSecondary],
        //             begin: Alignment.topLeft,
        //             end: Alignment.topRight
        //           ),
        //         ),
        child: InkWell(
        onTap: function, // Function this button will perform
        child: Container(
          height: height,
          width: width,
          child: FittedBox(
            fit: BoxFit.contain,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.allertaStencil(fontSize: 50, fontWeight: FontWeight.bold)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Image.asset(imageLocation, alignment: Alignment.center,),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
