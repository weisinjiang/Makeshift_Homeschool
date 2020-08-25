import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_expanded.dart';
import 'package:provider/provider.dart';

import 'bookmark_button.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
  final bool
      inUsersProfilePage; // if the post belongs to the user. They can delete it

  const PostThumbnail({Key key, this.inUsersProfilePage}) : super(key: key);

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// get the user information
    final user = Provider.of<AuthProvider>(context, listen: false).getUser;

    /// get the post data from provider in Study screen
    final postData = Provider.of<Post>(context, listen: false);

    Widget ratingsIcon(double rating) {
      if (rating <= 5.0 && rating > 4.0) {
        return Icon(Icons.sentiment_very_satisfied, color: Colors.green,size: 30,);
      }
      else if (rating <= 4.0 && rating > 3.0) {
        return Icon(Icons.sentiment_satisfied, color: Colors.lightGreen,);
      }
      else if (rating <= 3.0 && rating > 2.0) {
        return Icon(Icons.sentiment_neutral, color: Colors.amber, size: 30,);
      }
      else if (rating <= 2.0 && rating > 1.0) {
        return Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent,size: 30,);
      } 
      else {
        return Icon(Icons.sentiment_dissatisfied, color: Colors.red,size: 30,);
      }
    }

    return InkWell(
      /// On tap, the screen moves to an expanded post screen
      onTap: () {
        if (inUsersProfilePage) {

          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostExpanded(
                postData: postData,
                canDelete: true,
              )));
        } else {
          postData.incrementPostViewCount();
          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostExpanded(
                postData: postData,
                canDelete: false,
              )));
        }
      },
      child: Container(
          height: screenSize.height * 0.20,
          width: screenSize.width * 0.35,

          /// Box decoration for the shape of the container and the image that
          /// goes inside of it
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: kRedOrange, width: 3),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.80), BlendMode.dstATop),
                  image: NetworkImage(postData.getImageUrl),
                  fit: BoxFit.cover)),

          /// Title of the post
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Align(
                  alignment: Alignment.topRight,
                     child: Container(
                       
                    child: BookmarkButton(postData: postData, screenSize: screenSize, user: user),
                  ),
                ),
                
                Flexible(
                  fit: FlexFit.tight,
                  child: StrokeText(
                      fontSize: 15,
                      strokeColor: Colors.black,
                      strokeWidth: 3.0,
                      text: postData.getTitle,
                      textColor: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: ratingsIcon(postData.getRating),
                ),
                SizedBox(
                  height: 10,
                ),

                Flexible(
                fit: FlexFit.tight,
                  child: Container(
                    child: StrokeText(
                        fontSize: 16,
                        strokeColor: Colors.black,
                        strokeWidth: 3.0,
                        text: "Age: ${postData.getAge}+",
                        textColor: Colors.white),
                  ),
                ),
              
              ],
            ),
          )),
    );
  }
}
