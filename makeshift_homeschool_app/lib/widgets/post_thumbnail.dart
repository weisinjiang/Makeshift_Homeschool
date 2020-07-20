import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';


/// Clickable thumbnail before going into the actual post
class PostThumbnail extends StatelessWidget {
  final String imageUrl;
  final String title;

  const PostThumbnail({Key key, this.imageUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: screenSize.width/3,
        height: screenSize.height/5,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Stack(children: <Widget>[
          Opacity(opacity: 0.50, child: Image.network(imageUrl)),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kGreenPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        // bottomLeft
                        offset: Offset(-1.5, -1.5),
                        color: Colors.black),
                    Shadow(
                        // bottomRight
                        offset: Offset(1.5, -1.5),
                        color: Colors.black),
                    Shadow(
                        // topRight
                        offset: Offset(1.5, 1.5),
                        color: Colors.black),
                    Shadow(
                        // topLeft
                        offset: Offset(-1.5, 1.5),
                        color: Colors.black),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
