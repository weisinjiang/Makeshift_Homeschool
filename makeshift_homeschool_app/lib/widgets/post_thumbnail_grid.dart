import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

class PostThumbnailGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<PostFeedProvider>(context);
    final postsList = postsData.getPosts;

    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: postsList.length,
        itemBuilder: (context, index) => Provider.value( // provider to just access the value in PostThubnail Widget
            value: postsList[index], child: PostThumbnail()));
  }
}
