import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/services/auth.dart';
import 'package:makeshift_homeschool_app/shared/enums.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:makeshift_homeschool_app/shared/stroke_text.dart';
import 'package:makeshift_homeschool_app/widgets/post_expanded.dart';
import 'package:makeshift_homeschool_app/widgets/post_review.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'bookmark_button.dart';

/// Clickable thumbnail before going into the actual post

class PostThumbnail extends StatelessWidget {
  final PostExpandedViewType viewType;
  final bool isVideo;
  const PostThumbnail({Key key, this.viewType, this.isVideo}) : super(key: key);

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    /// get the user information
    final userInfo = Provider.of<AuthProvider>(context, listen: false).getUserInfo;

    /// get the post data from provider, switch types depending on isVideo
    var postData = isVideo 
      ? Provider.of<VideoPost>(context, listen: false)
      : Provider.of<Post>(context, listen: false);

    // makes the entire thumbnail widget to be clickable
    return InkWell(
      /// On tap, the screen moves to an expanded post screen
      onTap: () {
        // user profile page allows the post to be deleted
        if (viewType == PostExpandedViewType.owner) {
          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostExpanded(
                postData: postData,
                viewType: PostExpandedViewType.owner,
                isVideo: isVideo,
              )));
        } else if (viewType == PostExpandedViewType.principle) {
          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostReview(
                postData: postData,
                reviewer: Reviewer.principle,
              )));
        } else if (viewType == PostExpandedViewType.teacher) {
          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostReview(
                postData: postData,
                reviewer: Reviewer.teacher,
              )));
        }
        // if not user's profile, user cant delete posts
        else {
          // view count goes up whenever the post is accessed
          if (isVideo) {
            Provider.of<VideoPost>(context, listen: false).incrementPostViewCount();
          }
          else { 
            Provider.of<Post>(context, listen: false).incrementPostViewCount();      
          }
          Navigator.push(
              context,
              SlideLeftRoute(
                  screen: PostExpanded(
                postData: postData,
                isVideo: isVideo,
                viewType: PostExpandedViewType.global,
              )));
        }
      },
      child: Container(
          height: kIsWeb
            ? screenSize.height * 0.20
            :screenSize.height * 0.20,
          width: kIsWeb
            ? screenSize.width * 0.10
            :screenSize.width * 0.40,

          /// Box decoration for the shape of the container and the image that
          /// goes inside of it
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.black, width: 2),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.80), BlendMode.dstATop),
                  image: isVideo
                  ? NetworkImage("https://img.youtube.com/vi/${Provider.of<VideoPost>(context, listen: false).getVideoID}/0.jpg")
                  : NetworkImage(Provider.of<Post>(context, listen: false).getImageUrl),
                  fit: BoxFit.cover)),

          /// Title of the post
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bookmark option is avliable to people learning only
                if (viewType == PostExpandedViewType.global)
                  Align(
                    alignment: Alignment.topRight,
                    child: FittedBox(
                      fit: BoxFit.fill,                    
                      child: Container(
                        child: BookmarkButton(
                            postData: postData,
                            screenSize: screenSize,
                            userInfo: userInfo,
                            isVideo: isVideo,
                            ),
                      ),
                    ),
                  ),

                // Show the post date for Principles
                if (viewType == PostExpandedViewType.principle)
                  Flexible(
                      fit: FlexFit.tight,
                      child: StrokeText(
                        fontSize: 26,
                        strokeColor: Colors.black,
                        strokeWidth: 3.0,
                        text: isVideo 
                        ? Provider.of<VideoPost>(context, listen: false).getFormattedDateCreated()
                        : Provider.of<Post>(context, listen: false).getCreatedOn(),
                        textColor: Colors.white,
                      )),

                Flexible(
                  fit: FlexFit.tight,
                  child: StrokeText(
                      fontSize: 14,
                      strokeColor: Colors.black,
                      strokeWidth: 4.0,
                      text: isVideo 
                        ? Provider.of<VideoPost>(context, listen: false).getTitle.toUpperCase()
                        : Provider.of<Post>(context, listen: false).getTitle.toUpperCase(),
                      textColor: Colors.red),
                ),
                
               
               

                // Principles do not need to see the rating
                // if (viewType != PostExpandedViewType.principle)
                //   Flexible(
                //     fit: FlexFit.tight,
                //     child: Text(postData.ratingsEmojiString(), style: TextStyle(fontSize: 20),)
                //   ),

                if (viewType == PostExpandedViewType.principle)
                  Flexible(
                      fit: FlexFit.tight,
                      child: StrokeText(
                        fontSize: 15,
                        strokeColor: Colors.black,
                        strokeWidth: 4.0,
                        text: isVideo 
                        ? "By: ${Provider.of<VideoPost>(context, listen: false).getOwner}"
                        : "By: ${Provider.of<Post>(context, listen: false).getOwnerName}",
                        textColor: Colors.red,
                      )),

                
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    child: StrokeText(
                        fontSize: 16,
                        strokeColor: Colors.black,
                        strokeWidth: 4.0,
                        text: isVideo 
                        ? "Age: ${Provider.of<VideoPost>(context, listen: false).getAge.toString()}+"
                        : "Age: ${Provider.of<Post>(context, listen: false).getAge}+",
                        textColor: Colors.red),
                  ),
                ),

                // For Article Quizes only
                if (!isVideo && Provider.of<Post>(context, listen: false).isCompleted) 
                Flexible(
                  fit: FlexFit.tight,
                  child: Icon(FontAwesomeIcons.check, color: Colors.green[300],)
                  ),
              ],
            ),
          )),
    );
  }
}
