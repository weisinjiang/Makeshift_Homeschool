import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:makeshift_homeschool_app/shared/exportShared.dart';
import 'package:makeshift_homeschool_app/widgets/post_thumbnail.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
///

class StudyPage extends StatelessWidget {
 
  Widget build(BuildContext context) {
    var postFeedProvider =
        Provider.of<PostFeedProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: FutureBuilder(
        future: postFeedProvider.getPostsFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data;
            return Container(
              child: GridView.builder(
                
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: posts.length,
                  itemBuilder: (context, index) => PostThumbnail(
                        imageUrl: posts[index].getImageUrl,
                        title: posts[index].getPostContents[0],
                      )),
            );
          }
          return LoadingScreen();
        },
      ),
    );
  }
}
