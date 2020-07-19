import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:provider/provider.dart';

/// Study screen where lessons are retrieved from the database and posted
///

class StudyPage extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    var postFeedProvider = Provider.of<PostFeedProvider>(context);

    return FutureBuilder(
      future: postFeedProvider.getPostsFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final posts = postFeedProvider.getPosts;
          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: posts.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: posts[index],
              child: Column(children: <Widget>[
                Text(posts[index].getPostContents[0]),

              ],),
            ),
            
          );
        }
      },
    );
  }
}
