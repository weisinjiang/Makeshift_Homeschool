import 'package:flutter/material.dart';
import 'package:makeshift_homeschool_app/models/post_model.dart';
import 'package:makeshift_homeschool_app/services/post_feed_provider.dart';
import 'package:provider/provider.dart';

/// App bar that has actions, allowing users to:
///   1. Delete Post
///   2. Edit Post

class CanEditPostAppBar extends StatelessWidget {
  const CanEditPostAppBar({
    Key key,
    @required final this.postData,
    @required final this.screenSize,
  }) : super(key: key);

  final Post postData;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(postData.getTitle),
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
                            Container(
                              height: screenSize.height * 0.06,
                              width: screenSize.width * 0.85,
                              child: RaisedButton(
                                color: Colors.transparent,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  await Provider.of<PostFeedProvider>(
                                          context,
                                          listen: false)
                                      .deletePost(postData.getPostId);
                                  Navigator.of(context).pop(); /// pop 
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
                                onPressed: () {}
                                ,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              })
        ],
      );
  }
}