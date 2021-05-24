import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:makeshift_homeschool_app/screens/new_post_screen.dart';
import 'package:makeshift_homeschool_app/screens/new_video_screen.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/services/video_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/slide_transition.dart';
import 'package:provider/provider.dart';

/*
  PopupMenuAppBar is an AppBar that contains additional functions
  On press, users can do the following actions based on post type:
    if the post belongs to the user:
      Delete, Edit Post
    otherwise,
      report a post 
  
  @param postData - contents of the post that is being viewed
  @param canDelete - if accessed from user's profile, this is true. Else, false
  @param screenSize - size of the screen from the screen calling this widget
  @param appBar - Appbar() passed from the scaffold calling this widget
*/

class PopupMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  PopupMenuAppBar({
    Key key,
    @required final this.postData,
    @required final this.screenSize,
    this.backgroundColor,
    this.appBar,
    this.canDelete, this.isVideo,
  }) : super(key: key);

  final postData;
  final bool isVideo;
  final Color backgroundColor;
  final bool canDelete;
  final AppBar appBar;
  final Size screenSize;

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.red
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Text(postData.getTitle.toUpperCase()),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: screenSize.height * 0.40,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (canDelete) ...[
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.85,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  onPrimary: Colors.red
                                ),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                  
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  if (!isVideo) {
                                    await Provider.of<PostFeedProvider>(context,listen: false).deletePost(postData.getPostId);
                                  }
                                  else {
                                    VideoPost videoData = postData;
                                    await Provider.of<VideoFeedProvider>(context,listen: false).deletePost(postID:videoData.getLessonID);
                                  }
                                  Navigator.of(context).pop();
                                  /// pop
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.85,
                              child: RaisedButton(
                                color: Colors.transparent,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  isVideo
                                  ? Navigator.push(context,
                                    SlideLeftRoute(
                                      screen: NewVideoPostScreen(
                                      isEditing: true,
                                      postData: postData,
                                    )))
                                  :Navigator.push(context,
                                    SlideLeftRoute(
                                      screen: NewPostScreen(
                                      isEditing: true,
                                      postData: postData,
                                    )));
                
                                },
                              ),
                            ),
                          ]
                          // Not users post, others can report the post
                          else ...[
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.85,
                              child: ElevatedButton(
                                style: buttonStyle,
                                child: Text(
                                  "Report",
                                  style: TextStyle(
                                      //color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {},
                              ),
                            ),
                          ]
                        ],
                      ),
                    );
                  });
            })
      ],
    );
  }
}
