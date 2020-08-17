import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
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
                Icons.favorite,
                color: Colors.red,
                size: screenSize.height * 0.05,
              )
            : Icon(
                Icons.favorite_border,
                color: Colors.red,
                size: screenSize.height * 0.05,
              ),
        onPressed: () async {
          await post.toggleLikeButton(user["uid"]);
        },
      ),
    );
  }
}