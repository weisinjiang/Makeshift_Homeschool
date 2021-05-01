import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/models/videopost_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    Key key,
    this.postData,
    @required this.screenSize,
    @required this.userInfo,
    @required this.isVideo,
  }) : super(key: key);

  final postData;
  final Size screenSize;
  final Map<String, dynamic> userInfo;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return isVideo
    ? Consumer<VideoPost>(
      builder: (context, post, _) => IconButton(
        icon: postData.isLiked
            ? Icon(
                Icons.bookmark,
                color: Colors.black,
                size: kIsWeb
                  ? screenSize.height * 0.03 
                  :screenSize.height * 0.03,
              )
            : Icon(
                Icons.bookmark_border,
                color: Colors.black,
                size: kIsWeb
                  ? screenSize.height * 0.03 
                  : screenSize.height * 0.03,
              ),
        onPressed: () async {
          await post.toggleBookmarkButton(userInfo["uid"]);
        },
      ),
    )
    : Consumer<Post>(
      builder: (context, post, _) => IconButton(
        icon: postData.isLiked
            ? Icon(
                Icons.bookmark,
                color: Colors.black,
                size: kIsWeb
                  ? screenSize.height * 0.03 
                  :screenSize.height * 0.03,
              )
            : Icon(
                Icons.bookmark_border,
                color: Colors.black,
                size: kIsWeb
                  ? screenSize.height * 0.03 
                  : screenSize.height * 0.03,
              ),
        onPressed: () async {
          await post.toggleBookmarkButton(userInfo["uid"]);
        },
      ),
    );
  }
}