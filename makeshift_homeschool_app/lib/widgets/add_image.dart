import 'package:flutter/material.dart';

/// First provides an empty image and on tap, let's the user pick an image

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  /// Default to be shown before a user selects an image
  Image _onScreenImage = Image.asset("asset/images/imagePlaceHolder.png");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
    );
  }
}
