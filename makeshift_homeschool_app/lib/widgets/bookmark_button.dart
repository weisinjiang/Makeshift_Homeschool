import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

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
          await post.toggleBookmarkButton(user["uid"]);
        },
      ),
    );
  }
}