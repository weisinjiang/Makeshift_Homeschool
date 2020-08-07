import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/color_const.dart';
import 'package:makeshift_homeschool_app/shared/constants.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_expanded.dart';
import 'package:provider/provider.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
 

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    /// get the user information
    final user = Provider.of<AuthProvider>(context, listen: false).getUser;
    /// get the post data from provider in Study screen
    final postData = Provider.of<Post>(context, listen: false);

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
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Consumer<Post>(
                    builder: (context, post, _) => IconButton(
                      icon: postData.isLiked
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: screenSize.height * 0.05,
                            )
                          : Icon(Icons.favorite_border, color: Colors.red, size:screenSize.height * 0.05,),
                      onPressed: () async {
                        await post.toggleLikeButton(
                            user["uid"], postData.getPostId);
                      },
                    ),
                  ),
                  title: FittedBox(
                                      child: StrokeText(
                        fontSize: 30,
                        strokeColor: Colors.black,
                        strokeWidth: 4.0,
                        text: postData.getTitle,
                        textColor: Colors.white),
                  ),
                  subtitle: StrokeText(
                    fontSize: 20,
                    strokeColor: Colors.black,
                    strokeWidth: 4.0,
                    text: "By: ${postData.getOwnerName}",
                    textColor: Colors.white,
                  ),
                ),
                // FittedBox(
                //     fit: BoxFit.contain,
                //     child: StrokeText(
                //       fontSize: 20,
                //       strokeColor: Colors.black,
                //       strokeWidth: 4.0,
                //       text: postData.getTitle,
                //       textColor: kGreenPrimary,
                //     )),
              ],
            ),
          )),
    );
  }
}
