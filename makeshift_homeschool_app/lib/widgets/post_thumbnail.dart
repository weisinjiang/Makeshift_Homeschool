import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_expanded.dart';
import 'package:provider/provider.dart';

import 'like_button.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
  final bool inUsersProfilePage; // if the post belongs to the user. They can delete it

  const PostThumbnail({Key key, this.inUsersProfilePage}) : super(key: key);

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// get the user information
    final user = Provider.of<AuthProvider>(context, listen: false).getUser;

    /// get the post data from provider in Study screen
    final postData = Provider.of<Post>(context, listen: false);

    return InkWell(
      /// On tap, the screen moves to an expanded post screen
      onTap: () => {
        if (inUsersProfilePage) {
          Navigator.push(
          context,
          SlideLeftRoute(
              screen: PostExpanded(
            postData: postData,
            canDelete: true,
          )))
        }
        else {
          Navigator.push(
          context,
          SlideLeftRoute(
              screen: PostExpanded(
            postData: postData,
            canDelete: false,
          )))
        }
      },
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
            child: Center(
              child: ListTile(
                leading: LikeButton(
                    postData: postData, screenSize: screenSize, user: user),
                title: Container(
                  child: StrokeText(
                      fontSize: 20,
                      strokeColor: Colors.black,
                      strokeWidth: 5.0,
                      text: postData.getTitle,
                      textColor: Colors.white),
                ),
                subtitle: StrokeText(
                  fontSize: 16,
                  strokeColor: Colors.black,
                  strokeWidth: 4.0,
                  text:
                      "By: ${postData.getOwnerName}\nRecommended Age: ${postData.getAge}",
                  textColor: Colors.white,
                ),
                isThreeLine: true,
              ),
            ),
          )),
    );
  }
}
