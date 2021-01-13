import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';

class IconLeadButton extends StatelessWidget {
  final String buttonName;
  final Icon icon;
  final Color borderColor;
  final Color borderfillColor;
  final Color textColor;
  final Color textStrokeColor;
  final Size screenSize;
  final double textSize;
  final double textStrokeWidth;
  final double borderWidth;
  final double borderRadius;
  final Function function;

  const IconLeadButton(
      {Key key,
      this.buttonName,
      this.icon,
      this.borderColor,
      this.textColor,
      this.textStrokeColor,
      this.screenSize,
      this.textSize,
      this.function,
      this.borderWidth,
      this.borderRadius,
      this.borderfillColor, this.textStrokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
            // gradient: LinearGradient(  
            //   colors: [kPaleBlue, kRedOrange],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
              
            // ),
            color: borderfillColor),
        child: InkWell(
          onTap: function,
          child: Container(
            height: screenSize.height * 0.10,
            width: screenSize.width * 0.80,
            child: Container(
              alignment: Alignment.center,
              child: ListTile(
                leading: icon,
                title: Container(
                  child: StrokeText(
                    fontSize: textSize,
                    strokeColor: textStrokeColor,
                    strokeWidth: textStrokeWidth,
                    text: buttonName,
                    textColor: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
