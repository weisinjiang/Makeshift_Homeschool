import 'package:flutter/material.dart';

class GhostButton extends StatelessWidget {
  final Color buttonBorderColor;
  final Color buttonTextColor;
  final Color buttonFillColor;
  final double borderRadius;
  final String buttonName;
  final Function function;

  const GhostButton(
      {Key key,
      this.buttonBorderColor,
      this.buttonTextColor,
      this.buttonFillColor,
      this.buttonName,
      this.function, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: 0.0,
      child: Ink(
        decoration: BoxDecoration(  
          border: Border.all(color: buttonBorderColor, width: 3),
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonFillColor
        ),
        child: InkWell(
          onTap: function,
          child: Container(
            child: Center(
              child: Text(buttonName, style: TextStyle(
                color: buttonTextColor,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
