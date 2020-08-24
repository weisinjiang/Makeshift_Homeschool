import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/shared/colorPalete.dart';
import 'package:provider/provider.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    Key key,
    @required this.postData,
    @required this.screenSize,
    @required this.user,
  }) : super(key: key);

  final Post postData;
  final Size screenSize;
  final Map<String, String> user;

  @override
  Widget build(BuildContext context) {
    return Consumer<Post>(
      builder: (context, post, _) => IconButton(
        icon: postData.isLiked
            ? Icon(
                Icons.bookmark,
                color: kRedOrange,
                size: screenSize.height * 0.05,
              )
            : Icon(
                Icons.bookmark_border,
                color: kRedOrange,
                size: screenSize.height * 0.05,
              ),
        onPressed: () async {
          await post.toggleBookmarkButton(user["uid"]);
        },
      ),
    );
  }
}