import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_expanded.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
  final Post postData;

  const PostThumbnail({Key key, this.postData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return InkWell(
      /// On tap, the screen moves to an expanded post screen
      onTap: () => Navigator.push(
          context,
          SlideLeftRoute(
              screen: PostExpanded(
            postData: postData,
          ))),
      child: Container(
          width: screenSize.width * 0.40,
          height: screenSize.height * 0.20,

          /// Box decoration for the shape of the container and the image that
          /// goes inside of it
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.black, width: 5),
              image: DecorationImage(
                  image: NetworkImage(postData.getImageUrl),
                  fit: BoxFit.cover)),

          /// Title of the post
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
                child: StrokeText(
              fontSize: 20,
              strokeColor: Colors.black,
              strokeWidth: 4.0,
              text: postData.getTitle,
              textColor: kGreenPrimary,
            )),
          )),
    );
  }
}
