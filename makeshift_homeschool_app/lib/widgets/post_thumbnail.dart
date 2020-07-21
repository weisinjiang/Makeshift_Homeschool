import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

/// Clickable thumbnail before going into the actual post
class PostThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final postData = Provider.of<Post>(context); // Data provided by Provider in post_thumbnail_grid.dart

    return Center(
      child: Container(
        width: screenSize.width / 3,
        height: screenSize.height / 5,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Stack(children: <Widget>[
          Opacity(opacity: 0.50, child: Image.network(postData.getImageUrl)),
          Center(
            child: Text(
              postData.getTitle,
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
