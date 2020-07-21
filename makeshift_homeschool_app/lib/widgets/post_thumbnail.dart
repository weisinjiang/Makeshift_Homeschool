import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:provider/provider.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
  final Post postData;

  const PostThumbnail({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.50,
      height: screenSize.height * 0.30,
          child: InkWell(
            onTap: () {},
            child: Stack(
              children: [
                /// Container to contain the image and takes up the entire container
                /// using a FittedBox. Also used Opacity to lower the image so words
                /// can be seen

            
                Opacity(
                      opacity: 0.85,
                      child: Image.network(
                        postData.getImageUrl,
                      )),

                /// Same container size as above, but this had a column with text
                /// The column helps the text be flexiable and take up the entie
                /// container if the title gets too long
                /// Shadow helps with a black background
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: Text(
                            postData.getTitle,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
