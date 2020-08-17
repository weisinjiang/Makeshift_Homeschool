import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final Color textColor;
  final Color strokeColor;
  final double fontSize;
  final double strokeWidth;
  final String text;

  const StrokeText(
      {Key key, this.textColor, this.strokeColor, this.fontSize, this.text, this.strokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..color = strokeColor),
        ),
        
        // Solid text as fill.
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}